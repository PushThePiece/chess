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
  
  def checkmate?(king)
    #assume moves vaidated before here
    return false if check?(turn) == false #makes sure in check.
    return true if king.valid_moves? == false #checks if adjacent, can_capture, not occupied
    
    if king.valid_moves? == true #if there are valid moves, check to make sure not moving into check...
      valid_moves_2=[]
      king.valid_moves.each do |p1,p2|
        oldx=king.x
        oldy=king.y
        king.move_to!(p1,p2)
        if !square_under_attack?(king.color,p1,p2)
          valid_moves_2.push([p1,p2])
        end
        king.move_to!(oldx,oldy)
      end
      return true if valid_moves_2.empty?
      false
    end
    
    # return false if enemy_can_be_captured == true #check if allys_on_the_board can capture enemies_causing_check
    # enemies_causing_check=enemies_causing_check(king.color, king.x, king.y)

    # if ally_on_board(king.color)
    #   uncaptured=[] 
    #   enemies_causing_check.each do |enemy|
    #     ally_on_board(king.color).each do |ally|
    #       if ally.can_capture?(enemy.x,enemy.y) == false
    #         uncaptured.push(enemy)
    #       end
    #     end
    #     return uncaptured
    #   end
    # end
  end

  def stalemate(king)
    #check for moves out of check and if those moves are also in check.
    return true if king.valid_moves? == false #|| allys_on_board.can_capture == false
    if king.valid_moves? == true  
      moves_out_of_check = []
      king.valid_moves.each do |x,y|
        if square_under_attack?(king.color, x, y) == false
          moves_out_of_check.push([x,y])
        end
      end
      return false if moves_out_of_check == nil
      return true if moves_out_of_check !=nil
    end
  end
  
  def check?(turn)
    color = (turn == white_user_id) ? "white" : "black"
    king = find_king(color)
    return true if square_under_attack?(color, king.x, king.y)
    false
  end

  def enemy_can_be_captured

  end

  def enemies_causing_check(color,x,y)
    enemies = enemies_on_board(color)
    enemies_causing_check = []
    enemies.each do |enemy|
      enemies_causing_check.push(enemy) if enemy.valid_move?(x, y)
    end
    return enemies_causing_check
  end

  def square_under_attack?(color, x, y)
    return true if enemies_causing_check(color,x,y).any?
    false
  end

  def ally_on_board(color)
    pieces.where(x: 1..8, y: 1..8, color: color)
  end

  def enemies_on_board(color)
    opposite_color = (color == 'black') ? 'white' : 'black'
    pieces.where(x: 1..8, y: 1..8, color: opposite_color)
  end

  # def pieces_remaining(color)
  #   pieces.includes(:game).where(x: 1..8, y: 1..8, color: color)
  # end

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

  def player_email
    turn == white_user_id ?  white_player.email : black_player.email
  end

end
