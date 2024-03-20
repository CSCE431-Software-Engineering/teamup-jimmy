class MatchesController < ApplicationController
  def index
  end

  def pending
    @current_student = Student.find_by(email: session[:student_id])

    @pending_requests_A = Match.where(student1_email: @current_student, relationship_enum: 2)
    @pending_requests_B = Match.where(student2_email: @current_student, relationship_enum: 1)
    
    @pending_emails = Student.where(email: @pending_requests_A.pluck(:student2_email)).or(Student.where(email: @pending_requests_B.pluck(:student1_email)))    
  end

  def matched
    @current_student = Student.find_by(email: session[:student_id])

    # @existing_matches_A = Match.where(student1_email: @current_student, relationship_enum: 3)
    # @existing_matches_B = Match.where(student2_email: @current_student, relationship_enum: 3)

    @existing_matches_A = Match.where(student1_email: @current_student, relationship_enum: 0)
    
    # @matched_emails = Student.where(email: @existing_matches_A&.pluck(:student2_email)).or(Student.where(email: @existing_matches_B&.pluck(:student1_email)))    
    @matched_emails = Student.where(email: @existing_matches_A&.pluck(:student2_email))
    
    @major_class_hash = {}

    @matched_emails.each do |email|
      student = Student.find_by(email: email)
      if student.major && student.grad_year.nil?
        major_and_class = student.major
      elsif student.major.nil? && student.grad_year
        major_and_class = "Class of #{student.grad_year}"
      elsif student.major && student.grad_year
        major_and_class = "#{student.major} • Class of #{@student.grad_year}"
      else
        major_and_class = ""
      end
      @major_class_hash[email] = major_and_class
    end

  end

  def blocked
    @current_student = Student.find_by(email: session[:student_id])

    @existing_blocks_A = Match.where(student1_email: @current_student, relationship_enum: -1)
    @existing_blocks_B = Match.where(student2_email: @current_student, relationship_enum: -2)
    @existing_blocks_C = Match.where(student1_email: @current_student, relationship_enum: -3)
    @existing_blocks_D = Match.where(student2_email: @current_student, relationship_enum: -3)
    
    @blocked_emails = Student.where(email: @pending_requests_A.pluck(:student2_email)).or(Student.where(email: @pending_requests_B.pluck(:student1_email))).or(Student.where(email: @pending_requests_C.pluck(:student1_email))).or(Student.where(email: @pending_requests_D.pluck(:student1_email)))    
  end
end
