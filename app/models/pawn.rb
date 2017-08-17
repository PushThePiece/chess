class Pawn < Piece

  def unicode_point
    color == 'white' ? '&#9817' : '&#9823'
  end
end