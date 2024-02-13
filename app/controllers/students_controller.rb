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
    
    if Student.find_by(email: @student.email) || @student.save
      redirect_to controller: 'pages', action: 'home'
    else
      # The 'new' action is not being called here
      # Assign any instance variables needed
      flash[:notice] = 'Input cannot be blank'
      redirect_to(action: 'basic')
    end
  end

  private
  # need to add more fields
  def student_params
    params.require(:student).permit(:name, :email, :gender, :birthday)
  end
end
