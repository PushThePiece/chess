class Queen < Piece

  def image_piece
    color == 'white' ? '&#9813' : '&#9819'
  end

end
