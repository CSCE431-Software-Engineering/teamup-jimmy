class TimePreferencesController < ApplicationController
  before_action :time_table, only: [:index, :edit]
  def index
    @current_student = Student.find_by(email: session[:student_id])
    @time_preference = TimePreference.find_by(student_email: @current_student.email)
  end

  def new
  end

  def edit
  end

  private

  def iterate_over_times(times_string)
    times_string.chars.map { |char| char == '1' ? 'done' : '' }
  end

  def iterate_over_days(days_string)
    days_string.chars.map { |char| char == '1' ? 'done' : '' }
  end

  def time_table
    initialize_time_variables()
    time_table()
  end

  def new
  end

  def edit
    initialize_time_variables()
    time_table()
  end

  private

  def iterate_over_times(times_string)
    times_string.chars.map { |char| char == '1' ? 'done' : '' }
  end

  def initialize_time_variables()
    @current_student = Student.find_by(email: session[:student_id])
    @time_preference = TimePreference.find_by(student_email: @current_student.email)

    if @time_preference
      @morning_iter = @time_preference.morning
      @afternoon_iter = @time_preference.afternoon
      @evening_iter = @time_preference.evening
      @night_iter = @time_preference.night

    else
      @morning_iter, @afternoon_iter, @evening_iter, @night_iter = "", "", "", ""
    end
  end

  def time_table()
    initialize_time_variables()
    # @mon = [@morning_iter[0]] + [@afternoon_iter[0]] + [@evening_iter[0]] + [@night_iter[0]]
    days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    # Initialize an empty array to store the results
    @time_table = []

    # Iterate over the days of the week
    days_of_week.each_with_index do |day, index|
      # Build an array with data for each day
      data_for_day = [
        @morning_iter[index], 
        @afternoon_iter[index], 
        @evening_iter[index], 
        @night_iter[index]
      ]
      
      # Add the data for the day to the results array
      @time_table << [day, data_for_day]
    end
  end

end
