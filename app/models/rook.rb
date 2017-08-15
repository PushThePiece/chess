class Rook < Piece

  def image_piece
    color == 'white' ? '&#9814' : '&#9820'
  end

end