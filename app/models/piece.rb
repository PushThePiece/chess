class Piece < ApplicationRecord
  belongs_to :game
  self.inheritance_column 

  def self.types
    %w(Pawn Knight Rook King Queen Bishop)
  end
  
  def initialize(loc_x, loc_y, game)
    super()
    @x = loc_x
    @y = loc_y
    @game = game
  end
  

end
