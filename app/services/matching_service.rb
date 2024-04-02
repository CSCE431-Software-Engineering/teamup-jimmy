class MatchingService
  def initialize(current_user)
    @current_user = current_user
  end

  def match_students
    # Retrieve all users
    users = Student.all

    # Iterate through all combinations of users
    users.each do |user2|
      next if @current_user == user2 # skip comparing a user with themselves
      puts "Matching #{@current_user.email} with #{user2.email}"
      begin
        # Calculate match score for this pair of users
        match_score = calculate_match_score(@current_user, user2)

        match = Match.where(student1_email: @current_user.email, student2_email: user2.email).or(Match.where(student1_email: user2.email, student2_email: @current_user.email)).first
        if match.nil?
          match = Match.new(student1_email: @current_user.email, student2_email: user2.email, match_score: match_score)
        else
          match.match_score = match_score
        end
        puts "################################################################"
        puts "match score for #{match.student1_email} and #{match.student2_email} is #{match.match_score}"
        puts "################################################################"
        match.save # This line saves the match to the database, assuming that's the intended behavior
        
      rescue => e
        puts "Error creating match: #{e.message}"
      end
    end
  end

  private

  def calculate_match_score(current_user, user2)
    # Calculate match score based on activity preferences
    activity_match_score = calculate_activity_match_score(current_user, user2)

    # Calculate match score based on gym preferences
    gym_match_score = calculate_gym_match_score(current_user, user2)

    # Calculate match score based on time preferences
    time_match_score = calculate_time_match_score(current_user, user2)

    # Calculate overall match score (weight can be adjusted with extra checks)
    overall_match_score = (activity_match_score + gym_match_score + time_match_score) / 3.0

    # Return the overall match score
    overall_match_score
  end

  def calculate_activity_match_score(current_user, user2)
    # Retrieve activity preferences and experience levels for each user
    current_user_preferences = ActivityPreference.where(student_email: current_user.email)
    user2_preferences = ActivityPreference.where(student_email: user2.email)

    # Initialize variables to store common activities and their associated experience levels
    common_activities = []
    common_experience_levels = []

    # Iterate through each activity preference of the current user
    current_user_preferences.each do |preference|
      # Find the corresponding preference in user2's preferences
      matching_preference = user2_preferences.find_by(activity_id: preference.activity_id)

      # If a matching preference exists, add the activity and experience level to the common lists
      if matching_preference
        common_activities << preference.activity_id
        common_experience_levels << [preference.experience_level, matching_preference.experience_level]
      end
    end

    # Calculate the number of common activities
    common_activities_count = common_activities.count

    # Weight can be adjusted based on how important activity preferences are
    activity_weight = 0.33

    # Calculate match score based on common activities
    activity_match_score = common_activities_count.to_f / [current_user_preferences.count, user2_preferences.count].max

    # Factor in experience levels
    experience_scores = []

    # Represent levels as numeric values
    experience_weights = {
      "Beginner" => 1.0,
      "Advanced" => 2.0,
      "Intermediate" => 3.0,
      "Expert" => 4.0,
      "Novice" => 5.0
    }

    # Adjust match score based on experience levels of common activities
    common_experience_levels.each do |exp_level1, exp_level2|
      # Calculate the difference in experience levels
      experience_weight1 = experience_weights[exp_level1] || 1
      experience_weight2 = experience_weights[exp_level2] || 1
      experience_difference = (experience_weight1 - experience_weight2).abs

      # Apply formula to calculate the experience score for the pair of users
      experience_score = (-1 * experience_difference + 4) / 4.0

      # Add the experience score to the list of scores
      experience_scores << experience_score
    end

    # Average the experience scores for all common activities
    average_experience_score = experience_scores.sum / experience_scores.size.to_f

    # Update the activity match score with the weighted experience score
    activity_match_score += (average_experience_score - activity_match_score) * activity_weight

    # Check if the activity_match_score is NaN (occurs when there are no common activities -> experience levels)
    if activity_match_score.nan?
      activity_match_score = 0
    end

    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "Activity score: #{activity_match_score}"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

    # Return the activity match score
    activity_match_score
  end

  def calculate_gym_match_score(current_user, user2)
    # Retrieve gym preferences for each user
    current_user_gyms = GymPreference.where(student_email: current_user.email).pluck(:gym_id)
    user2_gyms = GymPreference.where(student_email: user2.email).pluck(:gym_id)

    # Calculate the number of common gyms
    common_gyms_count = (current_user_gyms & user2_gyms).count

    # Weight can be adjusted based on importance of gym preferences
    gym_weight = 0.33

    # Calculate match score absed on common gyms
    gym_match_score = common_gyms_count.to_f / [current_user_gyms.count, user2_gyms.count].max

    # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    # puts "Gym score: #{gym_match_score * gym_weight}"
    # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

    # Return the gym match score
    gym_match_score * gym_weight
  end

  def calculate_time_match_score(current_user, user2)
    # Retrieve time preferences for each user
    current_user_morning = TimePreference.where(student_email: current_user.email).pluck(:morning).first
    current_user_afternoon = TimePreference.where(student_email: current_user.email).pluck(:afternoon).first
    current_user_evening = TimePreference.where(student_email: current_user.email).pluck(:evening).first
    current_user_night = TimePreference.where(student_email: current_user.email).pluck(:night).first

    user2_morning = TimePreference.where(student_email: user2.email).pluck(:morning).first
    user2_afternoon = TimePreference.where(student_email: user2.email).pluck(:afternoon).first
    user2_evening = TimePreference.where(student_email: user2.email).pluck(:evening).first
    user2_night = TimePreference.where(student_email: user2.email).pluck(:night).first

    current_user_times = [current_user_morning, current_user_afternoon, current_user_evening, current_user_night]
    user2_times = [user2_morning, user2_afternoon, user2_evening, user2_night]

    # Initialize an array to store match scores for each time slot
    match_scores = []

    # Calculate match score for each time slot
    current_user_times.each_with_index do |current_user_time, index|
      user2_time = user2_times[index] || "0000000"

      # Convert time preferences to arrays of 0s and 1s
      current_user_time_array = current_user_time.chars.map(&:to_i)
      user2_time_array = user2_time.chars.map(&:to_i)

      # Calculate common preferences for this time slot
      common_preferences_count = current_user_time_array.zip(user2_time_array).count { |a, b| a == b }

      # Calculate match score for this time slot
      match_score = common_preferences_count.to_f / 7.0

      # Add match score for this time slot to the array
      match_scores << match_score
    end

    # Caluclate average match score across all time slots
    time_match_score = match_scores.sum / match_scores.size.to_f

    # Weight can be adjusted based on importance of time preferences
    time_weight = 0.33

    # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    # puts "Time score: #{time_match_score * time_weight}"
    # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

    # Return the overall match score
    time_match_score * time_weight
  end

end
