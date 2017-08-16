class Bishop < Piece
  
  def image_piece
    color == 'white' ? '&#9815' : '&#9821'
  end
end