class Game < ApplicationRecord

  has_many :pieces

  def populate_game!
    Rook.create(game_id: id, current_location: A1)
    Rook.create(game_id: id, current_location: H1)

  

  end

  
  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  def get_piece_at(x,y)
    return Piece.where(:x => x, :y => y, :game_id => id).first
  end


end
