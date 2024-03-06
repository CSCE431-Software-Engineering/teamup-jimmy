class ChangeIsPrivateDefaultOnStudents < ActiveRecord::Migration[7.0]
  def change
    Student.where(is_private: nil).update_all(is_private: false)
    change_column_default :students, :is_private, to: false
  end
end
