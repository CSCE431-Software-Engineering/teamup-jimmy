class GymPreferencesController < ApplicationController
  def index
    @current_student = Student.find_by(email: session[:student_id])
    @current_gyms = GymPreference.where(student_email: @current_student.email)
    @current_gyms_id = @current_gyms.pluck(:gym_id)
    @gyms = Gym.where(id: @current_gyms_id)

  end

  def edit
    @current_student = Student.find_by(email: session[:student_id])
    @gyms = Gym.all
    @new_gym = GymPreference.new()
  end

  def update
    @current_student = Student.find_by(email: session[:student_id])
    @gyms = Gym.all
    @new_gym = GymPreference.new(
      student_email: @current_student.email,
    )
    if @new_gym.save
      flash[:notice] = "Gym preference added successfully"
      redirect_to gym_preferences_path
    else
      render 'index'
    end
  end

  def new
    
  end

  def create
    @current_student = Student.find_by(email: session[:student_id])
    @gyms = Gym.all
    @new_gym = GymPreference.new(
      student_email: @current_student.email,
      gym_id: params[:gym_preference][:gym_id]    
    )
    if @new_gym.save
      flash[:notice] = "Gym preference has been added successfully"
      redirect_to gym_preferences_path
    else
      flash[:alert] = "Failed to add gym preference"
      redirect_to gym_preferences_path
    end
  end

  def delete
    @current_student = Student.find_by(email: session[:student_id])
  end

  def destroy
    @current_student = Student.find_by(email: session[:student_id])
    @gym_to_delete = GymPreference.find(params[:id])
    @gym_to_delete.destroy
    flash[:notice] = "Gym preference has been removed"
    redirect_to gym_preferences_path
  end

  def gym_preferences_params
    params.require(:gym_preferences).permit(:student_email, :gym_id,y)
  end

end
