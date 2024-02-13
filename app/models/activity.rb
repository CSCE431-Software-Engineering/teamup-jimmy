class Activity < ApplicationRecord
    has_many :experience_levels
    has_many :activity_preferences
    has_many :activity_logs
  end