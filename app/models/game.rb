class Game < ApplicationRecord

  has_many :pieces

  
  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  def get_piece_at(x,y)
    return pieces.find(x: x, y: y)
  end

end
