class ChangeGenderPrefStructure < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :gender_pref, :string

    add_column :students, :gender_pref_male, :boolean, default: true, null: false
    add_column :students, :gender_pref_female, :boolean, default: true, null: false
    add_column :students, :gender_pref_other, :boolean, default: true, null: false
  end
end
