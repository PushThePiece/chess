class King < Piece

  def is_move_valid?(dest_x, dest_y) 
    if x == dest_x
      (y - dest_y).abs <=1
    elsif y == dest_y
      (x - dest_x).abs <=1
    elsif is_adjacent?(dest_x, dest_y)
      return true
    else
      false
    end
  end

end