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
        puts match_score

        match = Match.where(student1_email: @current_user.email, student2_email: user2.email).or(Match.where(student1_email: user2.email, student2_email: @current_user.email)).first
        if match.nil?
          match = Match.new(student1_email: @current_user.email, student2_email: user2.email, match_score: match_score)
        else
          match.match_score = match_score
        end
        
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

    # Calculate overall match score (weight can be adjusted with extra checks)
    overall_match_score = (activity_match_score + gym_match_score) / 2.0

    # Return the overall match score
    overall_match_score
  end

  def calculate_activity_match_score(current_user, user2)
    # Retrieve activity preferences for each user
    current_user_activities = ActivityPreference.where(student_email: current_user.email).pluck(:activity_id)
    user2_activities = ActivityPreference.where(student_email: user2.email).pluck(:activity_id)

    # Calculate the number of common activities
    common_activities_count = (current_user_activities & user2_activities).count

    # Weight can be adjsuted based on how import activity preferences are
    activity_weight = 0.5

    # Calculate match score based on common activities
    activity_match_score = common_activities_count.to_f / [current_user_activities.count, user2_activities.count].max

    # Return the activity match score
    activity_match_score * activity_weight
  end

  def calculate_gym_match_score(current_user, user2)
    # Retrieve gym preferences for each user
    current_user_gyms = GymPreference.where(student_email: current_user.email).pluck(:gym_id)
    user2_gyms = GymPreference.where(student_email: user2.email).pluck(:gym_id)

    # Calculate the number of common gyms
    common_gyms_count = (current_user_gyms & user2_gyms).count

    # Weight can be adjusted based on importance of gym preferences
    gym_weight = 0.5

    # Calculate match score absed on common gyms
    gym_match_score = common_gyms_count.to_f / [current_user_gyms.count, user2_gyms.count].max

    # Return the gym match score
    gym_match_score * gym_weight
  end

end
