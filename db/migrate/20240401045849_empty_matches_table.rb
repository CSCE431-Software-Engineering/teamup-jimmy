class EmptyMatchesTable < ActiveRecord::Migration[7.0]
  def up
    Match.delete_all
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
