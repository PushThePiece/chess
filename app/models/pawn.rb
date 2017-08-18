class Pawn < Piece

  def unicode_point
    color == 'white' ? '&#9817' : '&#9823'
  end

  def valid_move?(dest_x,dest_y)
    return true if (dest_y - y) == 1 #advance a single square
    return true if y == 2 && (dest_y - y) == 2 # first move can advance 2 squares
    return true if game.is_occupied?(x+1, y+1) && dest_x == x+1 && dest_y == y+1 # capture on diagonal
    return false
  end
end