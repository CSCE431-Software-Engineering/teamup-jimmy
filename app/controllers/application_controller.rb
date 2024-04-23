# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :confirm_authenticated_account
  before_action :authenticate_account!
  before_action :set_initialization_false
  before_action :check_notifications

  def logout
    session[:student_id] = nil
    sign_out current_account
    redirect_to root_path
  end

  def confirm_authenticated_account
    if session[:student_id].nil?
      redirect_to root_path
    end
  end

  def set_initialization_false
    session[:render_account_creation_nav] = false
  end

  def check_notifications
    @current_student = Student.find_by(email: session[:student_id])
    puts "current student: #{@current_student}"
    if @current_student.nil?
      return
    end
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5"
    @has_incoming_requests = Match.where(student2_email: @current_student.email, relationship_enum: 1).or(Match.where(student1_email: @current_student.email, relationship_enum: 2)).length > 0
    puts "has incoming requests: #{@has_incoming_requests}"
  end
end
