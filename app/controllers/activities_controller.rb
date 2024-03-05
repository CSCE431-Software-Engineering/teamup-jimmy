class ActivitiesController < ApplicationController
  before_action :set_common_variable

  def index
    @activity_ids = ActivityPreference.where(student_email: @current_student.email).pluck(:activity_id)
    @exp_levels = ActivityPreference.where(student_email: @current_student.email).pluck(:experience_level)
    @current_activities = Activity.where(id: @activity_ids).pluck(:activity_name)
   
  end

  def new
    
  end

  def create
  end

  def edit
   
  end

  def update
  end

  private

  def set_common_variable
    @current_student = Student.find_by(email: session[:student_id])
    @acitivity = nil  # Set your common variable here
  end

end
