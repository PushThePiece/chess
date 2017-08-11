class AlterPiecesColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :current_location
    add_column :pieces, :x, :integer
    add_column :pieces, :y, :integer
    add_column :pieces, :color, :string
  end
end
