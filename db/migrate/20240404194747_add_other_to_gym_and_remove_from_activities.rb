class AddOtherToGymAndRemoveFromActivities < ActiveRecord::Migration[7.0]
  def change
    Gym.create(name: "Other")
  end
end
