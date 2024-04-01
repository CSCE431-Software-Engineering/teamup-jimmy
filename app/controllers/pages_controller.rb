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
      session[:reinit_match_score] = false
    end


    # initialize match queue
    if session[:match_queue].nil?
      possible_matches = Match.where(student1_email: @current_student.email)
              .or(Match.where(student2_email: @current_student.email, relationship_enum: 0))
              .where("match_score > 0")
              .order(match_score: :desc)
      incoming_requests = Match.where(student2_email: @current_student.email, relationship_enum: 1)
              .or(Match.where(student1_email: @current_student.email, relationship_enum: 2))
              .order(match_score: :desc)
      session[:match_queue] = incoming_requests + possible_matches
      session[:match_queue_index] = 0
    end


    # get next match
    if session[:match_queue].length > 0
      potential_match = session[:match_queue][session[:match_queue_index]]
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

      if session[:match_queue_index] >= session[:match_queue].length
        session[:match_queue_index] = 0
      end
    else
      @match = nil
    end
  end

  def browse; 
    @query = params[:query]

    if @query.present?
      # Updated to handle checkboxes
      @genders_filter = params[:genders] || []
      @genders_filter += ['Male'] if params[:male] == '1'
      @genders_filter += ['Female'] if params[:female] == '1'
      @genders_filter += ['Other'] if params[:other] == '1'

      name_condition = @query.present? ? "name ILIKE :query" : nil
      genders_condition = @genders_filter.present? ? "gender IN (:genders)" : nil

      conditions = [name_condition, genders_condition].compact.join(' AND ')
      @current_student = Student.find_by(email: session[:student_id])

      @results = Student.where(conditions, query: "%#{@query.downcase}%", genders: @genders_filter)
      @results = @results.where.not(email: @current_student.email)

      @results.each do |result|
        match = Match.where(student1_email: @current_student.email, student2_email: result.email).or(Match.where(student1_email: result.email, student2_email: @current_student.email)).first
        
        if !(match.nil?) && match.relationship_enum < 0
          @results = @results.where.not(email: result.email)
        end
      end

      @results = @results.where(is_private: false)
    else
      @results = -1
    end
  end

end
