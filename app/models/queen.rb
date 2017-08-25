class Queen < Piece

  def unicode_point
    color == 'white' ? '&#9813' : '&#9819'
  end

  def valid_move?(dest_x,dest_y)
    super
    is_horizontal?(dest_x,dest_y) || is_vertical?(dest_x,dest_y) || is_diagonal?(dest_x,dest_y)
  end

end
