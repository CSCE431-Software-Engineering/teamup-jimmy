# app/models/experience_level.rb
class ExperienceLevel < ApplicationRecord
    belongs_to :student
    belongs_to :activity
  end
  