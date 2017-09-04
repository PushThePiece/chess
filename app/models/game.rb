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

  def is_occupied?(x, y) #this doesn't seem to be working properly
    return false if get_piece_at(x,y).nil? || get_piece_at(x,y).captured?
    return true
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
    return threatening_pieces
  end
  
  def checkmate(king)
    #assume moves vaidated before here
    threatening_pieces = opponents_check?(king)
    # if there are threatening pieces move king to see if he can get out of check
    if threatening_pieces
      x = king.x
      y = king.y
      valid_moves = [] 
      ((y-1)..(y+1)).each do |y|
        ((x-1)..(x+1)).each do |x|
          if get_piece_at(x,y).nil?
            if king.move_to!(x,y) 
              valid_moves << [x,y] 
            end
          end
        end
      end
      return false if valid_moves #true or #false
    else
      return false #return false if there are no threathening pieces
    end 
  end

    def stalemate(king)
    #assume moves vaidated before here
      threatening_pieces = opponents_check?(king)
      # if there are threatening pieces move king to see if he can get out of check
        if threatening_pieces
          x = king.x
          y = king.y
          valid_moves = [] 
          ((y-1)..(y+1)).each do |y|
            ((x-1)..(x+1)).each do |x|
              if get_piece_at(x,y).nil? #look for another piece
                if king.move_to!(x,y) 
                  valid_moves << [x,y]
                end
              end
            end
          end
        # if valid_moves #if there is a valid move out, see if king is still in check.
            #to do - needs check? method
        # end
      else
        return false #return false if there are no threathening pieces
      # end
    end 
  end

  def next_player(color)    
    if color == 'white'   
      update_attributes(turn: black_user_id)    
    else    
      update_attributes(turn: white_user_id)    
    end   
  end

end
