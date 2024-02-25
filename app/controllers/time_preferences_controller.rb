class TimePreferencesController < ApplicationController
  def index
    @current_student = Student.find_by(email: session[:student_id])
    @times = TimePreferencesController.find_by(student_email: current_student.email)
    @mornings = times.morning
    @afternoons = times.afternoon
    @evenings = times.evening
    @nights = times.night
    @days = times.days_of_the_week
    
    @morning_iter, @afternoon_iter, @evening_iter, @night_iter, @days_iter = [], [], [], [], []

    @mornings.each_char do |char|
      if char == '1'
        @morning_iter << "done"
      else 
        @morning_iter << ""
    end

    @afternoons.each_char do |char|
      if char == '1'
        @afternoon_iter << "done"
      else 
        @afternoon_iter << ""
    end

    @evenings.each_char do |char|
      if char == '1'
        @evening_iter << "done"
      else 
        @evening_iter << ""
    end 

    @nights.each_char do |char|
      if char == '1'
        @night_iter << "done"
      else 
        @night_iter << ""
    end 

    @days.each_char do |char|
      if char == '1'
        @days_iter << "done"
      else 
        @days_iter << ""
    end 
  end

  def new
  end

  def edit
  end
end
