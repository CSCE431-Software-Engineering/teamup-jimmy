class AddCascadeDeleteToGymPreferencesTimePreferencesMatches < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :time_preferences, :students, column: :student_email
    add_foreign_key :time_preferences, :students, column: :student_email, primary_key: "email", on_delete: :cascade

    remove_foreign_key :gym_preferences, :students, column: :student_email
    add_foreign_key :gym_preferences, :students, column: :student_email, primary_key: "email", on_delete: :cascade

    remove_foreign_key :matches, :students, column: :student1_email
    add_foreign_key :matches, :students, column: :student1_email, primary_key: "email", on_delete: :cascade

    remove_foreign_key :matches, :students, column: :student2_email
    add_foreign_key :matches, :students, column: :student2_email, primary_key: "email", on_delete: :cascade
  end
end
