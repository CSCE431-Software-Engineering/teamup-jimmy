class AddReceivesMatchEmailsToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :receives_match_emails, :boolean, default: true
  end
end
