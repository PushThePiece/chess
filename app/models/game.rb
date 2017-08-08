class Game < ApplicationRecord
  
  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  def get_piece_at(x,y)
    Game.find(..where piece.x == foo and piece.y == bar)
  end

end
