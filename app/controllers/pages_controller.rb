# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    # Fetch the current student
    @current_student = Student.find_by(email: session[:student_id])

    @existing_matches_A = Match.where(student1_email: @current_student, relationship_enum: 3)
    @existing_matches_B = Match.where(student2_email: @current_student, relationship_enum: 3)
    
    @matched_emails = Student.where(email: @existing_matches_A&.pluck(:student2_email)).or(Student.where(email: @existing_matches_B&.pluck(:student1_email)))  
  end

  def match 
    @current_student = Student.find_by(email: session[:student_id])

    if session[:reinit_match_score] == true
      matching_service = MatchingService.new(@current_student)
      matching_service.match_students
      session[:match_queue_index] = 0
      session[:reinit_match_score] = false
    end

    if session[:match_queue_index].nil?
      session[:match_queue_index] = 0
    end
    # initialize match queue
  
    puts "initializing match queue"
    possible_matches = Match.where(student1_email: @current_student.email, relationship_enum: 0)
            .or(Match.where(student2_email: @current_student.email, relationship_enum: 0))
            .where("match_score > 0")
            .order(match_score: :desc)
    puts "possible matches: #{possible_matches.length}"
    incoming_requests = Match.where(student2_email: @current_student.email, relationship_enum: 1)
            .or(Match.where(student1_email: @current_student.email, relationship_enum: 2))
            .order(match_score: :desc)

    puts "incoming requests: #{incoming_requests.length}"
    puts "possible matches: #{possible_matches.length}"
    match_queue = incoming_requests + possible_matches
    puts "length of match queue: #{match_queue.length}"

    puts "match queue: #{match_queue}"

    @match = nil
    # get next match
    if match_queue.length > 0
      potential_match = match_queue[session[:match_queue_index]]
      @match = potential_match
      if @current_student.email == potential_match["student1_email"]
        @featured_user = Student.find_by(email: potential_match["student2_email"])
      else
        @featured_user = Student.find_by(email: potential_match["student1_email"])
      end

      @shared_activities_ids = ActivityPreference.where(student_email: @current_student.email).pluck(:activity_id) & ActivityPreference.where(student_email: @featured_user.email).pluck(:activity_id)
      @shared_activities = Activity.where(id: @shared_activities_ids).pluck(:activity_name)
      @incoming_request = (potential_match["relationship_enum"]) > 0
      session[:match_queue_index] += 1

      if session[:match_queue_index] >= match_queue.length
        session[:match_queue_index] = 0
      end
    else
      @match = nil
    end
  end

  def browse
    @query = params[:query]
  
    # Check if name condition is present or if any filters are selected
    if @query.present? || params.values_at(:male, :female, :other, :age_min, :age_max).any?(&:present?)
      # Handle age filters
      min_age = params[:age_min].to_i
      max_age = params[:age_max].to_i
      min_birthdate = Date.today - min_age.years if min_age.positive?
      # puts min_birthdate
      max_birthdate = Date.today - max_age.years if max_age.positive?
      max_birthdate = max_birthdate - 365 if max_birthdate.present?

      # puts max_birthdate
  
      # conditions array
      conditions = []
  
      # name condition
      conditions << "name ILIKE :query" if @query.present?
  
      # gender filters 
      genders_filter = []
      genders_filter << 'Male' if params[:male] == '1'
      genders_filter << 'Female' if params[:female] == '1'
      genders_filter << 'Other' if params[:other] == '1'
      conditions << "gender IN (:genders)" if genders_filter.present?
  
      # age filters 
      if min_birthdate
        conditions << "birthday <= :min_birthdate"
      end

      if max_birthdate
        conditions << "birthday >= :max_birthdate"
      end
  
      # combine 
      condition_str = conditions.join(' AND ')
  
      @results = Student.where(condition_str, query: "%#{@query.downcase}%", genders: genders_filter, min_birthdate: min_birthdate, max_birthdate: max_birthdate)
    else
      # If search query is empty and no filters are selected, display all users
      @results = Student.all
    end
  
    # exclude user student and handle private profiles
    @current_student = Student.find_by(email: session[:student_id])
    @results = @results.where.not(email: @current_student.email) if @current_student
    @results = @results.where(is_private: false)

    @results.each do |s|
      age = (Date.today - s.birthday) / 365.24
      puts "Student #{s.name}'s age is #{age} years"
    end
  
    # Pagination or any other processing...
  end
  

  def faq
    @page_name = "FAQ"
    @back_page_path = students_settings_path
  end

end
