# frozen_string_literal: true

class StudentsController < ApplicationController

  before_action :set_current_student, only: [:index, :edit_gender_pref, :edit_age_pref, :personal_info, :edit_name, :edit_birthday, :edit_gender, :edit_grad_year, :edit_is_private, :edit_phone_number, :edit_major, :edit_biography, :matching_preferences, :edit_instagram_url, :edit_snap_url, :edit_x_url, :connect_socials, :workout_preferences, :update]
  def index
    if @current_student.major && @current_student.grad_year.nil?
      @major_and_class = @current_student.major
    elsif @current_student.major.nil? && @current_student.grad_year
      @major_and_class = "Class of #{@current_student.grad_year}"
    elsif @current_student.major && @current_student.grad_year
      @major_and_class = "#{@current_student.major} • Class of #{@current_student.grad_year}"
    else
      @major_and_class = ""
    end

    @activity_ids = ActivityPreference.where(student_email: @current_student.email).pluck(:activity_id)
    @current_activities = Activity.where(id: @activity_ids).pluck(:activity_name)
    
  end

  def new
    flash[:notice] = ''
  end

  def basic
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    # Regex pattern to check for a valid TAMU email
    tamu_email_regex = /\A[^@]+@(\w+\.)?tamu\.edu\z/

    # Verify the email format
    if tamu_email_regex.match?(@student.email)
      # If the email format is correct, split before the '@' sign if needed

      @student.email = @student.email.split('@').first
      if Student.find_by(email: @student.email) || @student.save
        session[:student_id] = @student.email
        redirect_to controller: 'pages', action: 'home'
      else
        flash[:alert] = 'There was a problem with your input. Please make sure to fill out every field.'
        redirect_to(action: 'basic')
      end
    else
      flash[:alert] = 'Email is not a valid TAMU email address.'
      redirect_to(action: 'basic')
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  def settings
    @current_student = Student.find_by(email: session[:student_id])
    return if @current_student

    flash[:alert] = 'You must be logged in to access this page.'
  end

  def personal_info
    if @current_student.is_private.nil?
      @account_publicity = "Account publicity not set"
    elsif @current_student.is_private
      @account_publicity = "Private account"
    else
      @account_publicity = "Public account"
    end

    render 'students/personal_info_forms/account_info_settings'
  end

  def matching_preferences
    render 'students/matching_preferences_forms/matching_preferences_settings'
  end

  def connect_socials
    render 'students/socials_forms/socials_settings'
  end

  def workout_preferences
    render 'students/workoutPref'
  end

  def update
    # Find the student by ID from the parameters
    @student = Student.find(params[:id])
    if @student.nil?
      flash[:alert] = "Student not found."
      redirect_back fallback_location: root_path and return
    end
    if @student.update(student_params)

      flash[:notice] = "Your account was successfully updated."
      redirect_to request.referer || default_path
    else
      flash[:alert] = "There was a problem updating your account."
      logger.info "Failed to update Student: #{student_params}"
    logger.info "Errors: #{@student.errors.full_messages}"


      redirect_to request.referer || default_path
    end
  end

  def edit_birthday
    render 'students/personal_info_forms/edit_birthday'
  end

  def edit_gender
    render 'students/personal_info_forms/edit_gender'
  end

  def edit_grad_year
    render 'students/personal_info_forms/edit_grad_year'
  end

  def edit_name
    render 'students/personal_info_forms/edit_name'
  end

  def edit_phone_number
    render 'students/personal_info_forms/edit_phone_number'
  end

  def edit_major
    render 'students/personal_info_forms/edit_major'
  end

  def edit_is_private
    render 'students/personal_info_forms/edit_is_private'
  end

  def edit_biography
    @biography_placeholder = ""
    if @current_student.biography.nil?
      @biography_placeholder = "Enter your biography"
    else
      @biography_placeholder = @current_student.biography
    end
    render 'students/personal_info_forms/edit_biography'
  end

  def edit_gender_pref
    render 'students/matching_preferences_forms/edit_gender_pref'
  end

  def edit_age_pref
    render 'students/matching_preferences_forms/edit_age_pref'
  end

  def edit_instagram_url
    render 'students/socials_forms/edit_instagram_link'
  end

  def edit_x_url
    render 'students/socials_forms/edit_x_link'
  end

  def edit_snap_url
    render 'students/socials_forms/edit_snapchat_link'
  end
  
  def start_matching
    # Fetch the current student
    @current_student = Student.find_by(email: session[:student_id])

    # Retrieve preferences and criteria for matching
    activity_preferences = @current_student.activity_preferences
    gym_preferences = @current_student.gym_preferences

    # Initialize the MatchingService with necessary parameters
    matching_service = MatchingService.new(@current_student)

    # Perform matching
    matches = matching_service.match_students

    # Redirect to the home page
    redirect_to pages_home_path, notice: "Matching process completed successfully!"
  end

  private

  def set_current_student
    @current_student = Student.find_by(email: session[:student_id])
    unless @current_student
      flash[:alert] = 'You must be logged in to access this page.'
    end
  end  
  
  # need to add more fields
  def student_params
    params.require(:student).permit(:name, :email, :gender, :birthday, :phone_number, :major, :is_private, :grad_year, :biography, :instagram_url, :x_url, :snap_url, :gender_pref_female, :gender_pref_male, :gender_pref_other, :age_start_pref, :age_end_pref)
  end
end
