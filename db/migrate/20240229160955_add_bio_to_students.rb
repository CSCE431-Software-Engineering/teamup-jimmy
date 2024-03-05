class AddBioToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :biography, :string unless column_exists?(:students, :biography)
  end
end
