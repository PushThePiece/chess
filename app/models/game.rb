class Game < ApplicationRecord
  after_create :populate_game!
  has_many :pieces

  
  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  def get_piece_at(x,y)
    return pieces.find(:x => x, :y => y)
  end

  private
  
  def populate_game!
    #white pieces
    (1..8).each do |i|
      Pawn.create(self: id, x: i, y: 2, color: 'white')
    end

    Rook.create(self: id, x: 1, y: 1, color: 'white')
    Rook.create(self: id, x: 8, y: 1, color: 'white')

    Knight.create(self: id, x: 2, y: 1, color: 'white')
    Knight.create(self: id, x: 7, y: 1, color: 'white')

    Bishop.create(self: id, x: 3, y: 1, color: 'white')
    Bishop.create(self: id, x: 6, y: 1, color: 'white')

    King.create(self: id, x: 4, y: 1, color: 'white')
    Queen.create(self: id, x: 5, y: 1, color: 'white')

    #black pieces
    (1..8).each do |i|
      Pawn.create(self: id, x: i, y: 7, color: 'black')
    end

    Rook.create(self: id, x: 1, y: 8, color: 'black')
    Rook.create(self: id, x: 8, y: 8, color: 'black')

    Knight.create(self: id, x: 2, y: 8, color: 'black')
    Knight.create(self: id, x: 7, y: 8, color: 'black')

    Bishop.create(self: id, x: 3, y: 8, color: 'black')
    Bishop.create(self: id, x: 6, y: 8, color: 'black')

    King.create(self: id, x: 4, y: 8, color: 'black')
    Queen.create(self: id, x: 5, y: 8, color: 'black')
  end


end
