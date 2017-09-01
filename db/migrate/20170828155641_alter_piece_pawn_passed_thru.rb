class AlterPiecePawnPassedThru < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :passed_thru?, :boolean, default: false
  end
end
