class AddColumnsToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :gender_pref, :string
    add_column :students, :age_start_pref, :integer
    add_column :students, :age_end_pref, :integer
    add_column :students, :phone_number, :string
    add_column :students, :major, :string
    add_column :students, :grad_year, :integer
    add_column :students, :is_private, :boolean
    add_column :students, :instagram_url, :string
    add_column :students, :x_url, :string
    add_column :students, :snap_url, :string
    add_column :students, :profile_picture_url, :string
  end
end
