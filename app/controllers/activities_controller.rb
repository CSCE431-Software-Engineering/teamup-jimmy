class ActivitiesController < ApplicationController
  def index
    @acitivities = Student.find_by(email: session[:student_id])
  end

  def new
  end

  def create
  end

  def edit
    @levels = ['Beginner', 'Novice', 'Intermediate', 'Advanced', 'Expert']
  end

  def update
  end
end
