# frozen_string_literal: true

class Gym < ApplicationRecord
  has_many :activity_logs
end
