# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :experience_levels
  has_many :activity_preferences
  has_many :student_activities
  has_many :gym_preferences
  has_many :time_preferences
  has_many :matches, foreign_key: 'student1_id'
  has_many :reverse_matches, class_name: 'Match', foreign_key: 'student2_id'
  validates :email, presence: { message: "*Email can't be blank." }
  validates :name, presence: { message: "*Name can't be blank." }, format: { with: /\A[a-zA-Z\s]+\z/, message: "*Name can only contain alphabetic values and spaces." }, length: { maximum: 50, message: "*Name must be less than 50 characters." }
  validates :gender, presence: true, inclusion: { in: %w[Male Female Other] }
  validates :birthday, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "*Birthday must be in the format YYYY-MM-DD." }
  validates :major, presence: false
  validates :major, format: { with: /\A[a-zA-Z\s]+\z/, message: "*Major can only contain alphabetic values and spaces." }, allow_blank: true
  validates :is_private, presence: false
  validates :biography, presence: false, length: { maximum: 144, message: "*Biography must be less than 144 characters." }
  validates :age_start_pref, presence: true
  validates :age_end_pref, presence: true, numericality: { greater_than_or_equal_to: :age_start_pref }
  validates :x_url, format: { with: /\A(?:(?:http|https):\/\/)?(?:www\.)?x\.com\/.+\z/, message: "*Input must be a valid X URL." }, allow_blank: true
  validates :instagram_url, format: { with: /\A(?:(?:http|https):\/\/)?(?:www\.)?instagram\.com\/.+\z/, message: "*Input must be a valid Instagram URL." }, allow_blank: true
  validates :receives_match_emails, inclusion: { in: [true, false] }

  validates :phone_number, format: { with: /\A\d{10}\z/, message: "*Phone number must be exactly 10 digits long." }, allow_blank: true
  validates :grad_year, format: { with: /\A\d{4}\z/, message: "*Graduation year must be a four-digit number." }, allow_blank: true


  validates_inclusion_of :gender_pref_female, in: [true, false]
  validates_inclusion_of :gender_pref_male, in: [true, false]
  validates_inclusion_of :gender_pref_other, in: [true, false]

  has_one_attached :avatar


  validate :must_be_18

  private

  def must_be_18
    return if birthday.blank?

    if birthday > 18.years.ago.to_date
      errors.add(:birthday, '*You must be at least 18 years old to register.')
    end
  end

end
