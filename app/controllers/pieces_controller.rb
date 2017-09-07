class PiecesController < ApplicationController
  
  def show
    redirect_to game_path(current_piece.game)
  end

  def update
    #this is at the state:
    # - doesn't allow the wrong player to take a turn, 
    # - doesn't allow the wrong player to move either piece
    # - allows game.turn to move either piece...
    # user is piece.player && user is up for his turn
    # <user> == <user> && <user.id> == <user.id> need piece  
    if current_user == current_piece.player && current_user.id == current_game.turn && players_piece
      current_piece.move_to!(piece_params["x"].to_i, piece_params["y"].to_i)
      next_player(current_piece.color) #currently need refresh. Need integration with javascript
      render json: :current_piece
    else
      flash[:alert] = "It is not currently your turn or that is not your player piece"
      redirect_to game_path(current_piece.game)
    end
  end

  private 

  helper_method :current_game, :next_player, :players_piece

  def current_game
    # @piece = Piece.find(params[:id])
    @current_game ||= current_piece.game
  end

  def piece_params
    params.require(:piece).permit(:x, :y)
  end

  def current_piece
    @piece = Piece.find(params[:id])
  end

  def next_player(color)
    @piece = Piece.find(params[:id])
    @game = @piece.game
    @next_player = @piece.opponent(color)
    @game.update_attributes(turn: @next_player.id)
  end

  def players_piece

    if current_piece.player == current_game.black_player && current_piece.color == 'black'
      return true
    elsif current_piece.player == current_game.white_player && current_piece.color == 'white'
      return true
    else
      false
    end
  end
   
end
