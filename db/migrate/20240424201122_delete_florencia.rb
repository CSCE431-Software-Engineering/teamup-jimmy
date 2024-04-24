class DeleteFlorencia < ActiveRecord::Migration[7.0]
  def change
    Student.where(email: 'florencia.mangini').destroy_all
  end
end
