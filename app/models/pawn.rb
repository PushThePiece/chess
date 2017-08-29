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
    return true if !has_moved? && dest_x == x && dest_y == y+2*advance_unit && !game.is_occupied?(x, y+2*advance_unit)
    
    #capture right
    return true if dest_x == x+1 && dest_y == y+advance_unit && game.is_occupied?(x+1, y+advance_unit) && game.get_piece_at(x+1, y+advance_unit).color != color
    
    #capture left
    return true if dest_x == x-1 && dest_y == y+advance_unit && game.is_occupied?(x-1, y+advance_unit) && game.get_piece_at(x-1, y+advance_unit).color != color

    return true if can_enpassant?(dest_x)

    return false
  end

  def move_to!(new_x, new_y)
    
    update_attributes(passed_thru?: false) if passed_thru? == true

    if color=="white" && y == 2 && new_y == 4 || color == "black" && y == 7 && new_y == 5
        update_attributes(passed_thru?: true)
    end

    super

    capture_enpassant!(new_x) if can_enpassant?(new_x)

    update_attributes(:has_moved? => true) if has_moved? == false


  end

  def can_enpassant?(file)
    
    return false if (file - x).abs != 1

    rank = (color == "white") ? 6 : 4
    return false if y != rank

    opp_piece = game.get_piece_at(file, y)

    return false unless opp_piece.type == "Pawn" && opp_piece.passed_thru? == true

  end

  def capture_enpassant!(file)
    return false if !can_enpassant?(file)
    advance_unit = (color == "white" ? 1 : -1)
    game.get_piece_at(file, y).remove_from_game!
    update_attributes(x: file, y: y+advance_unit)
    return true
  end
end