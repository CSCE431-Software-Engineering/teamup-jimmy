# frozen_string_literal: true

class GymPreference < ApplicationRecord
  belongs_to :student, foreign_key: 'student_email'
  belongs_to :gym
end
