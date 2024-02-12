class StudentsController < ApplicationController
  def index
  end

  def new
  end

  def basic
    @student = Student.new()
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to controller: 'pages', action: 'home'
    else
      # The 'new' action is not being called here
      # Assign any instance variables needed
      render('pages/home')
    end
  end

  private
  # need to add more fields
  def student_params
    params.require(:student).permit(:name, :email, :gender, :birthday)
  end
end
