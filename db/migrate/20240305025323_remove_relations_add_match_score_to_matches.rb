class RemoveRelationsAddMatchScoreToMatches < ActiveRecord::Migration[6.0]
  def change
    # Remove the 'relation' attribute
    remove_column :matches, :relation

    # Add the 'match_score' attribute
    add_column :matches, :match_score, :decimal, precision: 10, scale: 2
  end
end
