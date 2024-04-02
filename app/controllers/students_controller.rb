# frozen_string_literal: true

class StudentsController < ApplicationController

  before_action :set_current_student, only: [:index, :set_profile_args, :delete_confirmation, :delete, :destroy, :edit_gender_pref, :edit_age_pref, :personal_info, :edit_name, :edit_birthday, :edit_gender, :edit_grad_year, :edit_is_private, :edit_phone_number, :edit_major, :edit_biography, :matching_preferences, :edit_instagram_url, :edit_snap_url, :edit_x_url, :connect_socials, :workout_preferences, :update, :upload_file, :delete_profile_picture]
  skip_before_action :set_initialization_false, only: [:new, :basic, :setup_personal_info, :setup_workout_partner_preferences, :setup_activity_preferences, :setup_gym_preferences, :setup_time_preferences, :create, :delete, :destroy, :update, :show, :set_profile_args, :set_current_student]

  
  def index
    redirect_to action: :show, id: @current_student.id and return if @current_student
  end

  def new
    flash[:notice] = ''
  end

  def basic
    flash[:notice] = ''
    @student = Student.new
    @default_name = ''
    @default_gender = 'Please select gender'
    @default_birthday = ''
    @default_phone_number = ''
    stu = Student.find_by(email: session[:student_id])
    if stu
      @default_name = stu.name
      @default_gender = stu.gender
      @default_birthday = stu.birthday
      @default_phone_number = stu.phone_number
    end
    render 'students/account_creation/basic'
  end

  def setup_personal_info
    flash[:notice] = ''
    @current_student = Student.find_by(email: session[:student_id])
    @default_major = '' || @current_student.major
    @default_grad_year = '' || @current_student.grad_year
    @default_biography = '' || @current_student.biography
    session['redirect_to'] = students_setup_workout_partner_preferences_path
    render 'students/account_creation/personal_info'
  end

  def setup_workout_partner_preferences
    flash[:notice] = ''
    @current_student = Student.find_by(email: session[:student_id])
    session['dont_render_nav'] = true
    session['render_account_creation_nav'] = true
    session['redirect_to'] = activity_preferences_path
    render 'students/account_creation/workout_partner_preferences'
  end

  def setup_activity_preferences
    @current_student = Student.find_by(email: session[:student_id])
  
    @activity_ids = ActivityPreference.where(student_email: @current_student.email).pluck(:activity_id)
    @current_activities = Activity.where(id: @activity_ids).pluck(:activity_name).to_a
    
    @exp_levels = []
    @current_activities.each do |name|
      @exp_levels << ActivityPreference.find_by(student_email: @current_student.email, activity_id: Activity.where(activity_name: name).pluck(:id)).experience_level
    end

    render 'students/account_creation/activity_preferences'
  end

  def create
    @student = Student.new(student_params)
    
    @student.email = session[:student_id]
    puts @student.email

    if Student.find_by(email: @student.email) || @student.save
      redirect_to students_setup_personal_info_path
    else
      flash[:alert] = 'There was a problem with your input. Please make sure to fill out every field.'
      redirect_to(action: 'basic')
    end
  end

  def show
    set_profile_args
  end

  def settings
    @current_student = Student.find_by(email: session[:student_id])
    return if @current_student

    flash[:alert] = 'You must be logged in to access this page.'
  end

  def delete_confirmation
  end

  def delete
  end

  def destroy
    if params[:id] == session[:student_id]
      @student_to_delelete = Student.find(params[:id])
      @student_to_delelete.destroy
      flash[:notice] = 'Your account was successfully deleted.'
      redirect_to root_path
    else
      flash[:alert] = 'You are not authorized to delete this account.'
      redirect_to students_index_path
    end
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
      session["reinit_match_score"] = true
      redirect_path = session["redirect_to"] || request.referer || root_path 
      session["redirect_to"] = nil
      redirect_to redirect_path
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

  def upload_file
    uploaded_file = params[:file]
  
    if uploaded_file
      s3 = Aws::S3::Resource.new
      bucket_name = 'jimmy-profile-pictures'
      bucket = s3.bucket(bucket_name)

      if uploaded_file.content_type.start_with?('image/')
        # Check if the current student already has a profile picture
        if @current_student.profile_picture_url.present?
          # Extract the key (filename) from the URL
          existing_key = URI.parse(@current_student.profile_picture_url).path.split('/').last
          # Delete the existing profile picture from S3
          bucket.object(existing_key).delete
          puts "The current image was deleted successfully!"
        end
    
        # Generate a unique filename
        file_key = SecureRandom.hex + File.extname(uploaded_file.original_filename)
        # Upload the file to S3
        obj = bucket.object(file_key)
        obj.upload_file(uploaded_file.tempfile, content_disposition: 'inline')
    
        # Update current_student's profile picture with the S3 URL
        @current_student.profile_picture_url = obj.public_url.to_s
        @current_student.save
    
        flash[:success] = "File uploaded successfully!"
      else
        puts "File type is not supported" 
      end
    else
      flash[:error] = "Please select a file to upload."
    end
    redirect_to students_settings_path
  end
  
  def delete_profile_picture
    if @current_student.profile_picture_url.present?
      s3 = Aws::S3::Resource.new
      bucket_name = 'jimmy-profile-pictures'
      bucket = s3.bucket(bucket_name)

      # Delete the profile picture
      existing_key = URI.parse(@current_student.profile_picture_url).path.split('/').last
      # Delete the existing profile picture from S3
      bucket.object(existing_key).delete
      puts "The current image was deleted from S3 successfully!"

      @current_student.profile_picture_url = nil
      @current_student.save
      puts "The current image was deleted from the database successfully!"

      flash[:success] = "Profile picture deleted successfully."
    else
      flash[:error] = "No profile picture to delete."
    end
    redirect_to students_settings_path
  end
  
  private

  def set_current_student
    @current_student = Student.find_by(email: session[:student_id])
    unless @current_student
      flash[:alert] = 'You must be logged in to access this page.'
    end
  end
  

  def set_profile_args
    @student = Student.find(params[:id])
    if @student.major && @student.grad_year.nil?
      @major_and_class = @student.major
    elsif @student.major.nil? && @student.grad_year
      @major_and_class = "Class of #{@student.grad_year}"
    elsif @student.major && @student.grad_year
      @major_and_class = "#{@student.major} • Class of #{@student.grad_year}"
    else
      @major_and_class = ""
    end

    @activity_ids = ActivityPreference.where(student_email: @student.email).pluck(:activity_id)
    @current_activities = Activity.where(id: @activity_ids).pluck(:activity_name)

    @can_block = false
    @can_unblock = false
    @can_send_match_request = false
    @can_cancel_match_request = false
    @can_accept_match_request = false
    @can_reject_match_request = false
    @can_unmatch = false
    set_current_student
    @number = -1
    if @student.email != @current_student.email
      @match = Match.where(student1_email: @current_student.email, student2_email: @student.email) .or(Match.where(student1_email: @student.email, student2_email: @current_student.email)).first
      if @match.relationship_enum == 3
        @number = @student.phone_number
      end
      if @number.nil? 
        @number = -1
      end
      if @match.nil?
        puts "match not founnd for student1: #{@current_student} and student2: #{@student}"
        @match = Match.new
        @match.relationship_enum = 0
        @match.student1_email = @current_student.email
        @match.student2_email = @student.email
        @match.save
        @match = Match.where(student1_email: @current_student.email, student2_email: @student.email) .or(Match.where(student1_email: @student.email, student2_email: @current_student.email)).first
      end
      if @match.student1_email == @current_student.email
        @can_block = (@match.relationship_enum == -2) || (@match.relationship_enum >= 0)
        @can_unblock = (@match.relationship_enum == -1) || (@match.relationship_enum == -3)
        @can_send_match_request = @match.relationship_enum == 0
        @can_cancel_match_request = @match.relationship_enum == 1
        @can_accept_match_request = @match.relationship_enum == 2
        @can_reject_match_request = @match.relationship_enum == 2
        @can_unmatch = @match.relationship_enum == 3
      elsif @match.student2_email == @current_student.email
        @can_block = (@match.relationship_enum == -1) || (@match.relationship_enum >= 0)
        @can_unblock = (@match.relationship_enum == -2) || (@match.relationship_enum == -3)
        @can_send_match_request = @match.relationship_enum == 0
        @can_cancel_match_request = @match.relationship_enum == 2
        @can_accept_match_request = @match.relationship_enum == 1
        @can_reject_match_request = @match.relationship_enum == 1
        @can_unmatch = @match.relationship_enum == 3
      end
      puts "can block: #{@can_block}"
      puts "can unblock: #{@can_unblock}"
      puts "can send match request: #{@can_send_match_request}"
      puts "can cancel match request: #{@can_cancel_match_request}"
      puts "can accept match request: #{@can_accept_match_request}"
      puts "can reject match request: #{@can_reject_match_request}"
      puts "can unmatch: #{@can_unmatch}"

    end
  end

  def student_params
    params.require(:student).permit(:name, :email, :gender, :birthday, :phone_number, :major, :is_private, :grad_year, :biography, :instagram_url, :x_url, :snap_url, :gender_pref_female, :gender_pref_male, :gender_pref_other, :age_start_pref, :age_end_pref)
  end
end
