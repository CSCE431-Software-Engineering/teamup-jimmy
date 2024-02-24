class ActivitiesController < ApplicationController
  def index
    @current_student = Student.find_by(email: session[:student_id])

    @activity_ids = ActivityPreference.where(student_email: @current_student.email).pluck(:activity_id)
    @exp_levels = ActivityPreference.where(student_email: @current_student.email).pluck(:experience_level)
    @current_activities = Activity.where(id: @activity_ids).pluck(:activity_name)
  end

  def new
    @activities = Activity.all()
  end

  def create
  end

  def edit
    @current_student = Student.find_by(email: session[:student_id])

    @activity = Activity.find(params[:id])
    @levels = ['Beginner', 'Novice', 'Intermediate', 'Advanced', 'Expert']

    @new_pref = ActivityPreference.new(activity_id: @activity.id, student_email: @current_student.email)

    if @new_pref.save
      redirect_to activities_path
    else
      render('edit')
    end

  end

  def update
  end

end
