class CreateStudentActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :student_activities do |t|
      t.string :student_email, null: false
      t.integer :activity_log_id, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :student_activities, :students, column: :student_email, primary_key: "email"
  end
end
