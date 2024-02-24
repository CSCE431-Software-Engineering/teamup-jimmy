class ChangeExperienceLevelType < ActiveRecord::Migration[7.0]
  def change
    change_column :activity_preferences, :experience_level, :string
  end
end
