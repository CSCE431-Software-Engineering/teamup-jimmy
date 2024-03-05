class MyMigration < ActiveRecord::Migration[6.0]
  def up
    # Drop tables
    drop_table :activity_logs if ActiveRecord::Base.connection.table_exists?('activity_logs')
    drop_table :experience_levels if ActiveRecord::Base.connection.table_exists?('experience_levels')
    drop_table :student_activities if ActiveRecord::Base.connection.table_exists?('student_activities')

    # Add experience_level column to activity_preferences
    add_column :activity_preferences, :experience_level, :integer unless column_exists?(:activity_preferences, :experience_level)
  end
end