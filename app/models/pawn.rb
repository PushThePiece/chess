class Pawn < Piece

  def unicode_point
    color == 'white' ? '&#9817' : '&#9823'
  end

  def valid_move?(dest_x,dest_y)
    return true if game.is_occupied?(x+1, y+1) && dest_x == x+1 && dest_y == y+1 # capture on diagonal

    is_empty_one = !game.is_occupied?(x, y+1)
    is_empty_two = is_empty_one && !game.is_occupied?(x, y+2)
    return true if (dest_x == x && dest_y == y+1) && is_empty_one #advance a single square if empty
    return true if (dest_x == x && dest_y == 4) && is_empty_two # first move can advance 2 squares
    return false
  end
end