class DropPieceTypeAlterPiece < ActiveRecord::Migration[5.0]
  def change
    drop_table :piece_types

    remove_column :pieces, :type_id
    add_column :pieces, :type, :string
  end
end
