class Pawn < Piece

  validates :passed_thru, presence: true, default: false

  def unicode_point
    color == 'white' ? '&#9817' : '&#9823'
  end

  def valid_move?(dest_x,dest_y)
    return true if (dest_x == x+1 && dest_y == y+1 && game.is_occupied?(x+1, y+1) && game.get_piece_at(x+1, y+1).color != color)
      || (dest_x == x-1 && dest_y == y+1 && game.is_occupied(x-1, y+1 && game.get_piece_at(x-1, y+1).color != color))

    is_empty_one = !game.is_occupied?(x, y+1)
    is_empty_two = is_empty_one && !game.is_occupied?(x, y+2)
    return true if (dest_x == x && dest_y == y+1) && is_empty_one #advance a single square if empty
    return true if (dest_x == x && dest_y == 4) && is_empty_two # first move can advance 2 squares
    return false
  end

  def can_enpassant?(file, opp_piece) #returns true if current player has en passant option
    
    #must be adjacent file
    return false if (file - x).abs != 1

    # must be on correct rank
    rank = (color == "white") ? 6 : 4
    return false if y != rank

    # opponent's piece must be a pawn at correct location
    return false unless opp_piece.type == "pawn" && 
      opp_piece.color != color && 
        opp_piece.passed_thru == true

    return true

  end

  def capture_enpassant!(file)
    opp_piece = game.get_piece_at(file, y)
    return false if !can_enpassant?(file, opp_piece)
    update_attributes(x: file, y: rank+1)
    opp_piece.remove_from_game!
  end
end