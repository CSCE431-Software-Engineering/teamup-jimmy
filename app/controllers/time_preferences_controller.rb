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

  def update
    # Assuming @current_student is already set
    @current_student = Student.find_by(email: session[:student_id])
    # Find or initialize the TimePreference record
    @time_preference = TimePreference.find_or_initialize_by(student_email: @current_student.email)
    
    # Process incoming parameters to construct preference strings
    process_time_preferences(params["time_preferences"])
    
    # Update the TimePreference record
    if @time_preference.update(morning: @morning, afternoon: @afternoon, evening: @evening, night: @night)
      # Handle successful update, e.g., redirect or render success message
      puts "yipee"
      # redirect_to some_path, notice: "Time preferences updated successfully."
    else
      # Handle errors, e.g., re-render the edit form with error messages
      render :edit
    end
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
    puts @time_preference
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

  private

  def time_preferences_params
    params.require(:student_email).permit(:morning, :afternoon, :evening, :night) 
  end

  def process_time_preferences(form_params)
    @morning = "0000000"
    @afternoon = "0000000"
    @evening = "0000000"
    @night = "0000000"

    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    puts form_params
    
    days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    days_of_week.each_with_index do |day, index|
      if form_params[day].nil? == false
        @morning[index] = '1' if form_params[day]["Morning"] == "1"
        @afternoon[index] = '1' if form_params[day]["Afternoon"] == "1"
        @evening[index] = '1' if form_params[day]["Evening"] == "1"
        @night[index] = '1' if form_params[day]["Night"] == "1"
      end
    end
  end


end
