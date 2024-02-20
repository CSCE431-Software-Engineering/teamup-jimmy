# frozen_string_literal: true

class CreateActivityLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_logs do |t|
      t.integer :activity_id, null: false, foreign_key: true
      t.integer :gym_id, null: false, foreign_key: true
      t.text :description
      t.decimal :hours
      t.date :date

      t.timestamps
    end
  end
end
