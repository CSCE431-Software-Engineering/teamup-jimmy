class AddOnDeleteCascadeToActivityPreferences < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :activity_preferences, :students, column: :student_email
    add_foreign_key :activity_preferences, :students, column: :student_email, primary_key: "email", on_delete: :cascade
  end 
end
