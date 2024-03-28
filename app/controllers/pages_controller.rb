# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    # Fetch the current student
    @current_student = Student.find_by(email: session[:student_id])

    @existing_matches_A = Match.where(student1_email: @current_student, relationship_enum: 3)
    @existing_matches_B = Match.where(student2_email: @current_student, relationship_enum: 3)
    
    @matched_emails = Student.where(email: @existing_matches_A&.pluck(:student2_email)).or(Student.where(email: @existing_matches_B&.pluck(:student1_email)))  
  end

  def match; end

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
