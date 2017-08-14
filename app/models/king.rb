class King < Piece

  def is_move_valid?(dest_x, dest_y) 
   is_adjacent?(dest_x, dest_y)
  end

end