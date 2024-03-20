class AddRelationshipEnumToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :relationship_enum, :integer, default: 0
  end
end
