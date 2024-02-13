class StudentActivity < ApplicationRecord
    belongs_to :student
    belongs_to :activity_log
  end