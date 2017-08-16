class Knight < Piece

  def unicode_point
    color == 'white' ? '&#9816' : '&#9822'
  end
end