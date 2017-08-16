class King < Piece


  def image_piece
    color == 'white' ? '&#9812' : '&#9818'
  end
  
  def is_move_valid?(dest_x, dest_y) 
   is_adjacent?(dest_x, dest_y)

  end

end