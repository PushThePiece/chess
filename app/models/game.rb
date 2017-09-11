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

  def is_occupied?(x, y)
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
  end
  
  def check?(turn)
    color = 'black'
    if white_user_id == turn
      color = 'white'
    end

    king = find_king(color)
    square_under_attack?(color, king.x, king.y)
  end

  def square_under_attack?(color, x, y)
    enemies = enemies_on_board(color)
    enemies_causing_check = []
    enemies.each do |enemy|
      enemies_causing_check.push(enemy) if enemy.valid_move?(x, y)
    end
    return true if !enemies_causing_check.empty?
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
