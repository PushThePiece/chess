class Bishop < Piece

  def unicode_point
    color == 'white' ? '&#9815' : '&#9821'
  end

  def valid_move?(dest_x,dest_y)
    is_diagonal?(dest_x,dest_y)

  end
end