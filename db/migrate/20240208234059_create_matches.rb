class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :student1_email, null: false
      t.string :student2_email, null: false
      t.string :relation

      t.timestamps
    end

    add_foreign_key :matches, :students, column: :student1_email, primary_key: "email"
    add_foreign_key :matches, :students, column: :student2_email, primary_key: "email"
  end
end
