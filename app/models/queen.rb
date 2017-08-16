class Queen < Piece
 
  def unicode_point
    color == 'white' ? '&#9813' : '&#9819'
  end
end
