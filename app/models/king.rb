class King < Piece

  def valid_move?(dest_x, dest_y) 
    super
    return false unless is_adjacent?(dest_x, dest_y) || is_castle?(dest_x, dest_y)
    rook = game.pieces.last
    if in_check?
      return false unless is_adjacent?(dest_x, dest_y) && !game.square_under_attack?(color, dest_x, dest_y)
    elsif is_castle?(dest_x, dest_y)
      coords = get_castling_corner(dest_x, dest_y)
      return false unless can_castle?(coords[0], coords[1])
    end
    return true
  end

  def move_to!(dest_x, dest_y)
    return false if super == false
    if is_castle?(dest_x, dest_y)
      coords = get_castling_corner(dest_x, dest_y)
      
      if can_castle?(coords[0], coords[1])
        castle!(coords[0], coords[1])
      else
        return false
      end
    end
    update_attributes(:has_moved? => true)
  end

  def in_check?
    return game.square_under_attack?(color, x, y)
  end

  def is_castle?(dest_x, dest_y)
    color_rank = (color=="white") ? 1 : 8
    return (dest_x - x == 2 || x - dest_x == 2) && dest_y == color_rank
  end

  def get_castling_corner(dest_x, dest_y)
    if dest_y == 1 && dest_x == 7
      return [8,1]
    elsif dest_y == 1 && dest_x == 3
      return [1,1]
    elsif dest_y == 8 && dest_x == 7
      return [8,8]
    elsif dest_y == 8 && dest_x == 3
      return [8,1]
    end
  end

  def can_castle?(corner_pos_x, corner_pos_y)

    return false if has_moved?
    piece = game.get_piece_at(corner_pos_x,corner_pos_y)
    return false if piece.nil? || piece.type != "Rook" || piece.has_moved?

    obstr_range = (piece.x == 8) ? [6, 7] : [2,3,4]
    obstr_range.each do |sq|
      return false if game.is_occupied?(sq, y)
      opp_color = (color == "white") ? "black" : "white"
      game.pieces.where(color: opp_color).each do |thepiece| 
        return false if thepiece.valid_move?(sq, y)
      end
    end
    return true
  end

  def castle!(corner_pos_x, corner_pos_y)

    rook = game.get_piece_at(corner_pos_x, corner_pos_y)
    if corner_pos_x == 8
      update_attributes(x: 7, y: corner_pos_y)
      rook.update_attributes!(x: 6, y: corner_pos_y)
    elsif corner_pos_x == 1
      update_attributes(x: 3, y: corner_pos_y)
      rook.update_attributes!(x: 4, y: corner_pos_y)
    end
    rook.update_attributes!(has_moved?: true)
    return true
  end

  def unicode_point
    color == 'white' ? '&#9812' : '&#9818'
  end
end