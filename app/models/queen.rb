class Queen < Piece

  def unicode_point
    color == 'white' ? '&#9813' : '&#9819'
  end

  def valid_move? (dest_x, dest_y)
  delta_x = (dest_x - x)
  delta_y = (dest_y - y)
    return false if delta_x != 0 && delta_y != 0 && delta_x.abs != delta_y.abs
  end


end
