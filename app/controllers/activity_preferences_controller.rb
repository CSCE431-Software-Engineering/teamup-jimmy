class ActivityPreferencesController < ApplicationController
  skip_before_action :set_initialization_false  
  
  def index
    @current_student = Student.find_by(email: session[:student_id])

    @activity_ids = ActivityPreference.where(student_email: @current_student.email).pluck(:activity_id)
    @current_activities = Activity.where(id: @activity_ids).pluck(:activity_name).to_a
    @dont_render_nav = !(session['dont_render_nav'].nil?)
    @render_account_creation_nav = session['render_account_creation_nav']
    if @render_account_creation_nav
      flash[:notice] = ''
    end
    @exp_levels = []
    @current_activities.each do |name|
      @exp_levels << ActivityPreference.find_by(student_email: @current_student.email, activity_id: Activity.where(activity_name: name).pluck(:id)).experience_level
    end

    if @render_account_creation_nav
      @back_page_path = students_setup_workout_partner_preferences_path
      @dont_render_nav = true
    else
      @back_page_path = students_workout_preferences_path
    end
    @page_name = "Activity Preferences"
  end

  def new
    @activities = Activity.all.order(:activity_name)

    @page_name = "Add Activity"
    @back_page_path = activity_preferences_path

    if session['render_account_creation_nav']
      @dont_render_nav = true
    end
  end

  def create
      @current_student = Student.find_by(email: session[:student_id])
      @activity = Activity.find(params[:activity_preference][:activity_id])
      @levels = ['Beginner', 'Novice', 'Intermediate', 'Advanced', 'Expert']
    
      @new_pref = ActivityPreference.new(
        activity_id: @activity.id,
        student_email: @current_student.email,
        experience_level: params[:activity_preference][:experience_level]
      )
    
      if @new_pref.save
        flash[:notice] = "Activity preference added successfully."
        session[:reinit_match_score] = true
        redirect_to activity_preferences_path
      else
        flash[:alert] = "Failed to add activity preference."
        render redirect_to activity_preferences_path
      end
    end

  def experience
      @current_student = Student.find_by(email: session[:student_id])
      @activity = Activity.find(params[:id])
      @levels = ['Beginner', 'Novice', 'Intermediate', 'Advanced', 'Expert']
  
      # Use the :create action to handle form submission
      @new_pref = ActivityPreference.new(activity_id: @activity.id, student_email: @current_student.email)

      @page_name = "Experience Level"
      @back_page_path = new_activity_preference_path

      if session['render_account_creation_nav']
        @dont_render_nav = true
      end
  end

  def update
  end

  def delete
    @current_student = Student.find_by(email: session[:student_id])
    @activity_to_delete = ActivityPreference.find_by(student_email: @current_student.email, activity_id: params[:activity_id])
  end

  def destroy
    @current_student = Student.find_by(email: session[:student_id])
    @activity_to_delete = ActivityPreference.find(params[:id])
    @activity_to_delete.destroy
    session[:reinit_match_score] = true
    flash[:notice] = "Activity preference deleted successfully."
    redirect_to activity_preferences_path
  end

  private
  def activity_preference_params
    params.require(:activity_preference).permit(:activity_id, :student_email, :experience_level)
  end
end
