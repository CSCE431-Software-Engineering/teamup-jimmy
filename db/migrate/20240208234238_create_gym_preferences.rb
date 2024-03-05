# frozen_string_literal: true

class CreateGymPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :gym_preferences do |t|
      t.string :student_email, null: false
      t.integer :gym_id, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :gym_preferences, :students, column: :student_email, primary_key: 'email'
  end
end
