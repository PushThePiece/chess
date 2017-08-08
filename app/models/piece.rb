class Piece < ApplicationRecord
  belongs_to :game
  self.inheritance_column :types

  def self.types
    %w(Pawn Knight Rook King Queen Bishop)
  end
end
