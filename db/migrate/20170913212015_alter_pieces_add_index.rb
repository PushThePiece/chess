class AlterPiecesAddIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :pieces, :game_id
    add_index :pieces, :type
  end
end
