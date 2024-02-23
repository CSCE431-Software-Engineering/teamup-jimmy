
class DeviseCreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :email, null: false
      t.string :full_name
      t.string :uid
      t.string :avatar_url

      t.timestamps null: false
    end

    add_index :accounts, :email, unique: true
  end
end