class GymPreference < ApplicationRecord
    belongs_to :student
    belongs_to :gym
  end