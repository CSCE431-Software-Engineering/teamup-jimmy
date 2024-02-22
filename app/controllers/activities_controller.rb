class ActivitiesController < ApplicationController
  def index
    @acitivities = Student.find_by(email: session[:student_id])
  end
end
