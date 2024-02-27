class GymPreferencesController < ApplicationController
  def index
    @current_student = Student.find_by(email: session[:student_id])
    @gyms = Gym.all
  end

  def edit
  end

  def update
  end

  def delete
    @current_student = Student.find_by(email: session[:student_id])
    @gym_to_delete = GymPreference.find_by(student_email: @current_student.email, gym_id: params[:gym_id])
  end

  def destroy
    @current_student = Student.find_by(email: session[:student_id])
    @gym_to_delete = GymPreference.find(params[:id])
    @gym_to_delete.destroy
    redirect_to activity_preferences_path
  end
end
