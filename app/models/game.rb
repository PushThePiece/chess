class Game < ApplicationRecord
  after_create :populate_game!
  has_many :pieces

  def self.create_game(params)
    game = Game.create(params)
    game.populate_game!
    game
  end
<<<<<<< HEAD

  def render_piece(piece)
    piece.color + " " + piece.type
  end

  private
=======
>>>>>>> e497ac3b0e4039e90ac7434dc34ef8caf9471945
  
  def populate_game!
    #white pieces
    (1..8).each do |position|
      Pawn.create(game_id: id, x: position, y: 2, color: 'white')
    end

    Rook.create(game_id: id, x: 1, y: 1, color: 'white')
    Rook.create(game_id: id, x: 8, y: 1, color: 'white')

    Knight.create(game_id: id, x: 2, y: 1, color: 'white')
    Knight.create(game_id: id, x: 7, y: 1, color: 'white')

    Bishop.create(game_id: id, x: 3, y: 1, color: 'white')
    Bishop.create(game_id: id, x: 6, y: 1, color: 'white')

    King.create(game_id: id, x: 4, y: 1, color: 'white')
    Queen.create(game_id: id, x: 5, y: 1, color: 'white')

    #black pieces
    (1..8).each do |position|
      Pawn.create(game_id: id, x: position, y: 7, color: 'black')
    end

    Rook.create(game_id: id, x: 1, y: 8, color: 'black')
    Rook.create(game_id: id, x: 8, y: 8, color: 'black')

    Knight.create(game_id: id, x: 2, y: 8, color: 'black')
    Knight.create(game_id: id, x: 7, y: 8, color: 'black')

    Bishop.create(game_id: id, x: 3, y: 8, color: 'black')
    Bishop.create(game_id: id, x: 6, y: 8, color: 'black')

    King.create(game_id: id, x: 4, y: 8, color: 'black')
    Queen.create(game_id: id, x: 5, y: 8, color: 'black')
  end

  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  
  def get_piece_at(x,y)
    return Piece.where(:x => x, :y => y, :game_id => id).last
  end
  
  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true

  end
end
