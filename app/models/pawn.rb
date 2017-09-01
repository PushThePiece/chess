class Pawn < Piece

  validates :passed_thru?, presence: true

  def unicode_point
    color == 'white' ? '&#9817' : '&#9823'
  end

  def valid_move?(dest_x,dest_y)
    
    advance_unit = (color == "white" ? 1 : -1)

    #move up 1 space
    return true if dest_x == x && dest_y == y + advance_unit && !game.is_occupied?(x, y+advance_unit)
    
    #move up 2 spaces
    return true if !has_moved? && dest_x == x && dest_y == y+2*advance_unit && !game.is_occupied?(x, y+advance_unit) && !game.is_occupied?(x, y+2*advance_unit)
    
    #capture right
    return true if dest_x == x+1 && dest_y == y+advance_unit && game.is_occupied?(x+1, y+advance_unit) && game.get_piece_at(x+1, y+advance_unit).color != color
    
    #capture left
    return true if dest_x == x-1 && dest_y == y+advance_unit && game.is_occupied?(x-1, y+advance_unit) && game.get_piece_at(x-1, y+advance_unit).color != color

    return true if can_enpassant?(dest_x)

    return false
  end

  def move_to!(new_x, new_y)
    
    return false if valid_move?(new_x, new_y) == false

    if can_enpassant?(new_x) == false
      opp_piece = game.get_piece_at(new_x, new_y)
      if !opp_piece.nil?
        opp_piece.remove_from_game!
      end
      if color=="white" && y == 2 && new_y == 4 || color == "black" && y == 7 && new_y == 5
        update_attributes(passed_thru?: true)
      end
      update_attributes(x: new_x, y: new_y, has_moved?: true)
      return true
    else
      capture_enpassant!(new_x)
      return true
    end

  end

  def can_enpassant?(file)
    
    return false if (file - x).abs != 1

    piece_rank = (color == "white") ? 5 : 4
    move_to_rank = (color == "white") ? piece_rank + 1 : piece_rank - 1

    return false if y != piece_rank
    return false if !game.get_piece_at(file, move_to_rank).nil?
    opp_piece = game.get_piece_at(file, y)
    return false if opp_piece.nil? || opp_piece.type != "Pawn" || opp_piece.color == color || !opp_piece.passed_thru?

    return true
  end

  def capture_enpassant!(file)
    advance_unit = (color == "white" ? 1 : -1)
    game.get_piece_at(file, y).remove_from_game!
    update_attributes(x: file, y: y+advance_unit)
    return true
  end
end