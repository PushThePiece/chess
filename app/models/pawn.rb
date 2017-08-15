class Pawn < Piece

  def image_piece
    color == 'white' ? '&#9817' : '&#9823'
  end

end