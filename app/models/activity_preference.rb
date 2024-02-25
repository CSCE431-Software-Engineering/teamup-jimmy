# frozen_string_literal: true

class ActivityPreference < ApplicationRecord
  belongs_to :student, foreign_key: 'student_email', primary_key: 'email'
  belongs_to :activity
end
