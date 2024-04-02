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
  validates :major, format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain alphabetic values and spaces" }, allow_blank: true
  validates :is_private, presence: false
  validates :biography, presence: false, length: { maximum: 144 }
  validates :age_start_pref, presence: true
  validates :age_end_pref, presence: true, numericality: { greater_than_or_equal_to: :age_start_pref }
  validates :x_url, format: { with: /\A(?:(?:http|https):\/\/)?(?:www\.)?x\.com\/.+\z/, message: "must be a valid X URL" }, allow_blank: true
  validates :instagram_url, format: { with: /\A(?:(?:http|https):\/\/)?(?:www\.)?instagram\.com\/.+\z/, message: "must be a valid Instagram URL" }, allow_blank: true

  validates :phone_number, format: { with: /\A\d{10}\z/, message: "must be exactly 10 digits long" }, allow_blank: true
  validates :grad_year, format: { with: /\A\d{4}\z/, message: "must be a four-digit year" }, allow_blank: true


  validates_inclusion_of :gender_pref_female, in: [true, false]
  validates_inclusion_of :gender_pref_male, in: [true, false]
  validates_inclusion_of :gender_pref_other, in: [true, false]

  has_one_attached :avatar
end
