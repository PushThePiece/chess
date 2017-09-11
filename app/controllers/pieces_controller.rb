class PiecesController < ApplicationController
  
  def show
    redirect_to game_path(current_piece.game)
  end

  def update
    if current_user == current_piece.player && current_user.id == current_game.turn && players_piece
      result = current_piece.move_to!(piece_params["x"].to_i, piece_params["y"].to_i)
      next_player(current_piece.color) if result == true
      redirect_to game_path(current_piece.game) #temp, needs to redirect through javascript
    else
      flash[:alert] = "It is not currently your turn or that is not your player piece"
      redirect_to game_path(current_piece.game) #temp, needs to redirect through javascript
    end
  end

  private 

  helper_method :current_game, :current_piece

  def current_game
    @current_game ||= current_piece.game
  end

  def piece_params
    params.require(:piece).permit(:x, :y)
  end

  def current_piece
    @piece = Piece.find(params[:id])
  end

  def next_player(color)
    @next_player = current_piece.opponent(color)
    current_game.update_attributes(turn: @next_player.id)
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
