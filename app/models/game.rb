class Game < ApplicationRecord
  
  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  def get_piece_at(x,y)
    
    #return nil => is_obstructed will always return false
    
    return Piece.new(x,y,self) # => is_obstructed always returns true immediately
    
    # To do: Database lookup here e.g.
    # Game.find(..where piece.x == foo and piece.y == bar) etc.
  end

end
