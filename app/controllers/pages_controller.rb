# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    # Fetch the current student
    @current_student = Student.find_by(email: session[:student_id])
    @matches = Match.where("student1_email = ?", @current_student.email)
  end

  def match; end
end
