# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :experience_levels
  has_many :activity_preferences
  has_many :student_activities
  has_many :gym_preferences
  has_many :time_preferences
  has_many :matches, foreign_key: 'student1_id'
  has_many :reverse_matches, class_name: 'Match', foreign_key: 'student2_id'
  validates :email, presence: true
  validates :name, presence: true
  validates :gender, presence: true, inclusion: { in: %w[Male Female Other] }
  validates :birthday, presence: true
end
