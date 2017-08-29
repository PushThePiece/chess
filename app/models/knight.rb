class Knight < Piece

  def unicode_point
    color == 'white' ? '&#9816' : '&#9822'
  end

  def valid_move?(dest_x,dest_y)

    if ((dest_x - x).abs == 1 && (dest_y - y).abs == 2) || ((dest_x - x).abs == 2 && (dest_y - y).abs == 1)
      return !game.is_occupied?(dest_x, dest_y) || can_capture?(dest_x, dest_y)
    else
      return false
    end
  end

end