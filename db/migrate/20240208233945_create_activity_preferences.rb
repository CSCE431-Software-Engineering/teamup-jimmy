# frozen_string_literal: true

class CreateActivityPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_preferences do |t|
      t.references :activity, null: false, foreign_key: true
      t.string :student_email, null: false

      t.timestamps
    end

    add_foreign_key :activity_preferences, :students, column: :student_email, primary_key: 'email'
  end
end
