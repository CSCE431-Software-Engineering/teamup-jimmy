# frozen_string_literal: true

class TimePreference < ApplicationRecord
  belongs_to :student, foreign_key: 'student_email', primary_key: 'email'
end
