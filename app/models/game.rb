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
  
  def in_check?
    fake_moves.any? #this is redundant code...
  end

  def opponents_check?(king)
    x=king.x
    y=king.y
    # if king is in check, returns list of pieces that threaten it
    threatening_pieces = []
    opponents_pieces = self.pieces.where(:color => "black" )
    opponents_pieces.each do |piece|
      if piece.move_to!(x, y)
        threatening_pieces << piece
      end
    end
    # threatening_pieces.any?
      return threatening_pieces
    # end
  end
  
  def checkmate(king)
    #assume moves vaidated before here
    threatening_pieces = opponents_check?(king)
    # if there are threatening pieces move king to see if he can get out of check
    # if threatening_pieces.any?
      puts fake_moves
      # undefined local variable or method `fake_moves' for #<Game:0x007fdf44fffc00>
     
      # return false if moves = king.fake_moves
      # return true if nil
    # else
      # return false #game is not in check if there are no threatening pieces
    # end 
  end


  def next_player(color)    
    if color == 'white'   
      update_attributes(turn: black_user_id)    
    else    
      update_attributes(turn: white_user_id)    
    end   
  end

end
