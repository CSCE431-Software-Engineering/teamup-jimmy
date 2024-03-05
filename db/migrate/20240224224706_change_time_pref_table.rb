class ChangeTimePrefTable < ActiveRecord::Migration[7.0]
  def change
    # Remove existing columns
    remove_column :time_preferences, :time_start
    remove_column :time_preferences, :time_end
    remove_column :time_preferences, :day

    # Add new columns
    # MTWTFSS
    # 0000000
    
    add_column :time_preferences, :morning, :string
    add_column :time_preferences, :afternoon, :string
    add_column :time_preferences, :evening, :string
    add_column :time_preferences, :night, :string
    add_column :time_preferences, :days_of_the_week, :string
  end
end
