class Game < ApplicationRecord

  after_create :populate_game!
  has_many :pieces

  def get_piece_at(x,y)
    return Piece.where(:x => x, :y => y, :game_id => id).last
  end

  def populate_game!
    #white pieces
    (1..8).each do |position|
      Pawn.create(game_id: id, x: position, y: 2, color: 'white', passed_thru?: false)
    end

    Rook.create(game_id: id, x: 1, y: 1, color: 'white')
    Rook.create(game_id: id, x: 8, y: 1, color: 'white')

    Knight.create(game_id: id, x: 2, y: 1, color: 'white')
    Knight.create(game_id: id, x: 7, y: 1, color: 'white')

    Bishop.create(game_id: id, x: 3, y: 1, color: 'white')
    Bishop.create(game_id: id, x: 6, y: 1, color: 'white')

    Queen.create(game_id: id, x: 4, y: 1, color: 'white')
    King.create(game_id: id, x: 5, y: 1, color: 'white')

    #black pieces
    (1..8).each do |position|
      Pawn.create(game_id: id, x: position, y: 7, color: 'black', passed_thru?: false)
    end

    Rook.create(game_id: id, x: 1, y: 8, color: 'black')
    Rook.create(game_id: id, x: 8, y: 8, color: 'black')

    Knight.create(game_id: id, x: 2, y: 8, color: 'black')
    Knight.create(game_id: id, x: 7, y: 8, color: 'black')

    Bishop.create(game_id: id, x: 3, y: 8, color: 'black')
    Bishop.create(game_id: id, x: 6, y: 8, color: 'black')
 
    Queen.create(game_id: id, x: 4, y: 8, color: 'black')
    King.create(game_id: id, x: 5, y: 8, color: 'black')

  end

  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end
  
  # I don't think code here is being used
  # def check?(color)
  #   king = pieces.find_by(type: 'King', color: color)
  #   opponents = pieces_remaining(!color)

  #   opponents.each do |piece|
  #     if piece.valid_move?(king.x, king.y)
  #       @piece_causing_check = piece
  #       return true
  #     end
  #   end
  #   false
  # end
  def opponents_causing_check?(king)
    # # if king is in check, returns list of pieces that threaten it
    # threatening_pieces = []
    # opponents_pieces = self.pieces.where(color: !king.color)
    # opponents_pieces.each do |piece|
    #   if piece.valid_move?(king.x, king.y)
    #     threatening_pieces << piece
    #   end
    # end
    # if threatening_pieces.any?
    #   return threatening_pieces
    # end
  end

  def checkmate(king)
    #assume moves vaidated before here
  #   #look for threathening pieces
  #   threatening_pieces = opponents_causing_check?(king)
  #   #if there are threatening pieces move king to see if he can get out of check
  #   if threathening_pieces
  #     moves = fake_moves(king.x, king.y)
  #     return false if moves? #not in checkmate, king has valid move out
  #   end 
  #   #if there are no threathening pieces game is not in checkmate
  #   return false
  #
  end

  
end
