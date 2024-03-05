# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    # Fetch the current student
    @current_student = Student.find_by(email: session[:student_id])
    @matches = Match.where("student1_email = ?", @current_student.email)
  end

  def match; end

  def browse; end

  def search
    @query = params[:query]
    puts @query

    # Updated to handle checkboxes
    @genders_filter = params[:genders] || []
    @genders_filter += ['Male'] if params[:male] == '1'
    @genders_filter += ['Female'] if params[:female] == '1'
    @genders_filter += ['Other'] if params[:other] == '1'

    puts @genders_filter

    name_condition = @query.present? ? "name ILIKE :query" : nil
    genders_condition = @genders_filter.present? ? "gender IN (:genders)" : nil

    conditions = [name_condition, genders_condition].compact.join(' AND ')

    @results = Student.where(conditions, query: "%#{@query.downcase}%", genders: @genders_filter)
  end
end
