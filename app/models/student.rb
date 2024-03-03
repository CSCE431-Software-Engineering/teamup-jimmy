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
  validates :major, presence: false
  validates :is_private, presence: false
  validates :biography, presence: false
  validates :age_start_pref, presence: true, allow_nil: true
  validates :age_end_pref, presence: true, allow_nil: true

  validates :phone_number, format: { with: /\A\d{10}\z/, message: "must be exactly 10 digits long" }, allow_blank: true
  validates :grad_year, format: { with: /\A\d{4}\z/, message: "must be a four-digit year" }, allow_blank: true


  validates_inclusion_of :gender_pref_female, in: [true, false], allow_nil: true
  validates_inclusion_of :gender_pref_male, in: [true, false], allow_nil: true
  validates_inclusion_of :gender_pref_other, in: [true, false], allow_nil: true
end
