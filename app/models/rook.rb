class Rook < Piece

  def unicode_point
    color == 'white' ? '&#9814' : '&#9820'
  end

  def move_to!(new_x, new_y)
    super
    update_attributes(:has_moved? => true) if has_moved? == false
  end

  def valid_move?(dest_x, dest_y)
    super
    is_horizontal?(dest_x, dest_y) || is_vertical?(dest_x, dest_y)
  end

end