class CreateTimePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :time_preferences do |t|
      t.string :student_email, null: false
      t.time :time_start
      t.time :time_end
      t.string :day

      t.timestamps
    end

    add_foreign_key :time_preferences, :students, column: :student_email, primary_key: "email"
  end
end
