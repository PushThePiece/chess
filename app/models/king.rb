class King < Piece

  def is_move_valid?(dest_x, dest_y) 
    is_adjacent?(dest_x, dest_y)
  end

  def can_castle_kingside
    return false if has_moved?
    corner_piece = color == "white" ? game.get_piece_at(8,1) : game.get_piece_at(8,8)
    return false if corner_piece.type != "Rook" || corner_piece.has_moved?
    return false if game.is_occupied?(7,1) || game.is_occupied?(6,1)
    return true
  end

  def castle_kingside!
    return false if !can_castle_kingside
    corner_piece = color == "white" ? game.get_piece_at(8,1) : game.get_piece_at(8,8)
    if color == "white" 
      update_attributes(:x => 7,:y => 1, :has_moved? => true)
      corner_piece.update_attributes!(:x => 6, :y => 1, :has_moved? => true)
      return true
    elsif color == "black"
      update_attributes(:x => 7,:y => 8, :has_moved? => true)
      corner_piece.update_attributes!(:x => 6, :y => 8, :has_moved? => true)
      return true
    end
  end

  def unicode_point
    color == 'white' ? '&#9812' : '&#9818'
  end
end