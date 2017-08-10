class King < Piece

  def is_move_valid?(dest_x, dest_y) 
    case @x != dest_x || @y != dest_y
    when @x == dest_x
      (@y - dest_y).abs <=1
    when @y == dest_y
      (@x - dest_x).abs <=1
    else
      false
    end 
  end
  
end