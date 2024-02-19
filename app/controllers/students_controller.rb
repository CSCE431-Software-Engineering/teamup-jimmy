class StudentsController < ApplicationController
  def index
  end

  def new
    flash[:notice] = ''
  end

  def basic
    @student = Student.new()
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
        redirect_to controller: 'pages', action: 'home'
      else
        flash[:notice] = 'There was a problem with your input. Please make sure to fill out every field.'
        redirect_to(action: 'basic')
      end
    else
      flash[:notice] = 'Email is not a valid TAMU email address.'
      redirect_to(action: 'basic')
    end
  end

  private
  # need to add more fields
  def student_params
    params.require(:student).permit(:name, :email, :gender, :birthday)
  end
end
