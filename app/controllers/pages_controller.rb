# frozen_string_literal: true

class PagesController < ApplicationController
  def home; end

  def match; end

  def browse; end

  def search
    @query = params[:query]
    puts @query
    @genders_filter = params[:genders]
    puts @genders_filer

    name_condition = @query.present? ? "name ILIKE :query" : nil
    genders_condition = @genders_filter.present? ? "gender IN (:genders)" : nil

    conditions = [name_condition, genders_condition].compact.join(' AND ')

    @results = Student.where(conditions, query: "%#{@query&.downcase}%", genders: @genders_filter)
  end
end
