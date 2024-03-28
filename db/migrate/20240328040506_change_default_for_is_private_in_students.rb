class ChangeDefaultForIsPrivateInStudents < ActiveRecord::Migration[7.0]
  def change
    change_column_default :students, :is_private, from: true, to: false
  end
end
