# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :student1, class_name: 'Student', foreign_key: 'student1_email', primary_key: 'email'
  belongs_to :student2, class_name: 'Student', foreign_key: 'student2_email', primary_key: 'email'
end
