class ActivityPreferencesController < ApplicationController
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
        @current_student = Student.find_by(email: session[:student_id])
        @activity = Activity.find(params[:activity_preference][:activity_id])
        @levels = ['Beginner', 'Novice', 'Intermediate', 'Advanced', 'Expert']
      
        @new_pref = ActivityPreference.new(
          activity_id: @activity.id,
          student_email: @current_student.email,
          experience_level: params[:activity_preference][:experience_level]
        )
      
        if @new_pref.save
          redirect_to activity_preferences_path
        else
          render 'experience'
        end
      end
  
    def experience
        @current_student = Student.find_by(email: session[:student_id])
        @activity = Activity.find(params[:id])
        @levels = ['Beginner', 'Novice', 'Intermediate', 'Advanced', 'Expert']
    
        # Use the :create action to handle form submission
        @new_pref = ActivityPreference.new(activity_id: @activity.id, student_email: @current_student.email)
    end
  
    def update
    end

    def activity_preference_params
        params.require(:activity_preference).permit(:activity_id, :student_email, :experience_level)
    end

    def delete
      @current_student = Student.find_by(email: session[:student_id])
      @activity_to_delete = ActivityPreference.find_by(student_email: @current_student.email, activity_id: params[:activity_id])
    end

    def destroy
      @current_student = Student.find_by(email: session[:student_id])
      @activity_to_delete = ActivityPreference.find(params[:id])
      @activity_to_delete.destroy
      redirect_to activity_preferences_path
    end
  
  end
  