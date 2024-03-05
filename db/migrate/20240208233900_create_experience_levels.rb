# frozen_string_literal: true

class CreateExperienceLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :experience_levels do |t|
      t.string :student_email, null: false
      t.references :activity, null: false, foreign_key: true
      t.integer :experience

      t.timestamps
    end

    add_foreign_key :experience_levels, :students, column: :student_email, primary_key: 'email'
  end
end
