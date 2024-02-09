class CreateGyms < ActiveRecord::Migration[7.0]
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :address
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
