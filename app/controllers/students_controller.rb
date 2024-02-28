# frozen_string_literal: true

class StudentsController < ApplicationController

  before_action :set_current_student, only: [:index, :personal_info, :edit_name, :edit_birthday, :edit_gender, :edit_grad_year]
  def index
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
    puts session[:student_id]
    @current_student = Student.find_by(email: session[:student_id])
    return if @current_student

    flash[:alert] = 'You must be logged in to access this page.'
  end

  def personal_info
    render 'students/personal_info_forms/account_info_settings'
  end

  def edit_name
    render 'students/personal_info_forms/edit_name'
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
      flash.now[:alert] = "There was a problem updating your account."
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
    set_current_student 
    render 'students/personal_info_forms/edit_name'
  end
  def edit_phone_number
    render 'students/personal_info_forms/edit_phone_number'
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
    params.require(:student).permit(:name, :email, :gender, :birthday)
  end

  def name_params
    params.require(:student).permit(:name)
  end
end
