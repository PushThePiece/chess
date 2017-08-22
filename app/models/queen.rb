class Queen < Piece

  def unicode_point
    color == 'white' ? '&#9813' : '&#9819'
  end

  def valid_move? (dest_x, dest_y)
    self.is_horizontal?(dest_x, dest_y) || self.is_vertical?(dest_x, _dest_y) || 
    self.is_diagonal?(dest_x, dest_y)
  end


end
