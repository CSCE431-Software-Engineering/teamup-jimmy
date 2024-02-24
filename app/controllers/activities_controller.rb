class ActivitiesController < ApplicationController
  def index
    @current_student = Student.find_by(email: session[:student_id])

    @activity_ids = ActivityPreference.where(student_email: @current_student.email).pluck(:activity_id)
    @exp_levels = ActivityPreference.where(student_email: @current_student.email).pluck(:experience_level)
    @activities = Activity.where(id: @activity_ids).pluck(:activity_name)
  end

  def new
    @activities = Activity.all()
  end

  def create
  end

  def edit
    @activity = Activity.find(params[:id])
    @levels = ['Beginner', 'Novice', 'Intermediate', 'Advanced', 'Expert']
  end

  def update
  end
end
