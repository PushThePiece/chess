class Game < ApplicationRecord
  after_create :populate_game!
  has_many :pieces

  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  def get_piece_at(x,y)
    return Piece.where(:x => x, :y => y, :game_id => id).first
  end

  private
  
  def populate_game!
    #white pieces
    (1..8).each do |i|
      Pawn.create(x: i, y: 2, color: 'white', game: self)
    end

    Rook.create(x: 1, y: 1, color: 'white', game: self)
    Rook.create(x: 8, y: 1, color: 'white', game: self)

    Knight.create(x: 2, y: 1, color: 'white', game: self)
    Knight.create(x: 7, y: 1, color: 'white', game: self)

    Bishop.create(x: 3, y: 1, color: 'white', game: self)
    Bishop.create(x: 6, y: 1, color: 'white', game: self)

    King.create(x: 4, y: 1, color: 'white', game: self)
    Queen.create(x: 5, y: 1, color: 'white', game: self)

    #black pieces
    (1..8).each do |i|
      Pawn.create(x: i, y: 7, color: 'black', game: self)
    end

    Rook.create(x: 1, y: 8, color: 'black', game: self)
    Rook.create(x: 8, y: 8, color: 'black', game: self)

    Knight.create(x: 2, y: 8, color: 'black', game: self)
    Knight.create(x: 7, y: 8, color: 'black', game: self)

    Bishop.create(x: 3, y: 8, color: 'black', game: self)
    Bishop.create(x: 6, y: 8, color: 'black', game: self)

    King.create(x: 4, y: 8, color: 'black', game: self)
    Queen.create(x: 5, y: 8, color: 'black', game: self)
  end
end
