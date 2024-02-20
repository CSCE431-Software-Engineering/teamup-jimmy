# frozen_string_literal: true

class ActivityPreference < ApplicationRecord
  belongs_to :student
  belongs_to :activity
end
