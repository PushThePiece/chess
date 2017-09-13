class AddWinnerLoserToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :winner, :integer
    add_index :games, :winner
  end
end
