class Match < ApplicationRecord
    belongs_to :student1, class_name: "Student"
    belongs_to :student2, class_name: "Student"
  end