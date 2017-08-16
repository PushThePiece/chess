class Knight < Piece

  def image_piece
    color == 'white' ? '&#9816' : '&#9822'
  end

end