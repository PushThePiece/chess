class King < Piece

  def is_move_valid?(dest_x, dest_y) 
    is_adjacent?(dest_x, dest_y)
  end

  def can_castle?(corner_pos_x, corner_pos_y)

    return false if has_moved? || corner_pos_y != y

    piece = game.get_piece_at(corner_pos_x,corner_pos_y)
    return false if piece.nil? || piece.type != "Rook" || piece.has_moved?

    obstr_range = (piece.x == 8) ? [6, 7] : [2,3,4]
    obstr_range.each { |sq| return false if game.is_occupied?(sq, y) }
    
    return true
  end

  def castle!(is_king_side = true)
    corner_pos_x = (is_king_side == true) ? 8 : 1
    corner_pos_y = (color == "white") ? 1 : 8

    return false if !can_castle?(corner_pos_x, corner_pos_y)

    rook = game.get_piece_at(corner_pos_x, corner_pos_y)

    update_attributes(corner_pos_x, corner_pos_y, :has_moved? => true)

    if is_king_side
      rook.update_attributes!(corner_pos_x - 2, corner_pos_y, :has_moved? => true)
    else
      rook.update_attributes!(corner_pos_x + 3, corner_pos_y, :has_moved? => true)
    end
    
    return true
  end

  def unicode_point
    color == 'white' ? '&#9812' : '&#9818'
  end
end