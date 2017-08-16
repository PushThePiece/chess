class Rook < Piece

  def unicode_point
    color == 'white' ? '&#9814' : '&#9820'
  end
  
end