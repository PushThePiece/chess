class Game < ApplicationRecord
  after_create :populate_game!
  has_many :pieces

  belongs_to :black_player, class_name: "User", foreign_key: :black_user_id, optional: :true
  belongs_to :white_player, class_name: "User", foreign_key: :white_user_id

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

  def is_occupied?(x, y) #this doesn't seem to be working properly
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end

  # def opponents_causing_check?(king)
  #   x=king.x
  #   y=king.y
  #   color = king.color
  #   # if king is in check, returns list of pieces that threaten it
  #   threatening_pieces = []
  #   opponents_pieces = self.pieces.where(:color => color.to_s )
  #   opponents_pieces.each do |piece|
  #     if piece.move_to!(x, y)
  #       threatening_pieces << piece
  #     end
  #   end
  #   return threatening_pieces
  # end
  
  def checkmate?(king)
    #assume moves vaidated before here
    return false if check?(king.color) == false
    if king.valid_moves?
      kings_valid_moves = []   
      king.valid_moves?.each do |move| #[[5,5], [4,5]] #true in checkmate or #false has a move out
        x = move[0] #check to see if King is in check after move.
        y = move[1]
        # byebug
        if square_under_attack?(king.color, x, y) == true
          kings_valid_moves.push(x)
        end
      end
      return true if kings_valid_moves.count > 2
      false
    end 
    # byebug
    return true #in check with no valid moves
  end
  
  def check?(color)
    king = find_king(color)
    return true if square_under_attack?(color, king.x, king.y)
    false
  end

  def square_under_attack?(color, x, y)
    enemies = enemies_on_board(color)
    enemies_causing_check = []
    enemies.each do |enemy|
      enemies_causing_check.push(enemy) if enemy.valid_move?(x, y)
    end
    return true if enemies_causing_check.any?
    false
  end

  def ally_on_board(color)
    pieces.where(x: 1..8, y: 1..8, color: color)
  end

  def enemies_on_board(color)
    opposite_color = (color == 'black') ? 'white' : 'black'
    pieces.where(x: 1..8, y: 1..8, color: opposite_color)
  end

  def pieces_remaining(color)
    pieces.includes(:game).where(x: 1..8, y: 1..8, color: color)
  end

  def find_king(color)
    pieces.where(type: 'King', color: color).last
  end

  def forfeit!(user)
    if user == 'white_user_id'
      forfeit_color = 'white'
    else
      forfeit_color = 'black'
    end
  end

end
