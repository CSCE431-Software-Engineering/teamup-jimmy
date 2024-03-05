# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students, id: false do |t|
      t.string :email, primary_key: true
      t.string :name
      t.string :gender
      t.date :birthday

      t.timestamps
    end
  end
end
