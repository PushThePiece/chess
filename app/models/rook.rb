class Rook < Piece

  def unicode_point
    color == 'white' ? '&#9814' : '&#9820'
  end

  def valid_move?(x, y)
    #assumes valid_move? in piece.rb has been verified prior to this step
    is_horizontal?(x, y) || is_vertical?(x, y)
  end

end