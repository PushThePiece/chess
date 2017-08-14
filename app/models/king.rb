class King < Piece

  def image_piece
    color == 'white' ? '&#9812' : '&#9818'
  end

end