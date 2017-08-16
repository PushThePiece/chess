class Bishop < Piece
  

  def unicode_point
    color == 'white' ? '&#9815' : '&#9821'
  end
end