class King < Piece

   def is_move_valid?(dest_x, dest_y) 
    is_adjacent?(dest_x, dest_y)
  end

  def unicode_point
    color == 'white' ? '&#9812' : '&#9818'
  end
end