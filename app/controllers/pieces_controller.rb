class PiecesController < ApplicationController
  
  def show
    redirect_to game_path(current_piece.game)
  end

  def update
    if !players_turn
      flash[:alert] = "It is not your turn"
      redirect_to game_path(current_piece.game) #temp, needs to redirect through javascript
    elsif !players_piece
      flash[:alert] = "That is not your piece"
      redirect_to game_path(current_piece.game) #temp, needs to redirect through javascript
    else
      result = current_piece.move_to!(piece_params["x"].to_i, piece_params["y"].to_i)
      next_player(current_piece.color) if result == true
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

  def players_turn
    return true if current_user.id == current_game.turn
  end

  def players_piece
    return true if current_user == current_piece.player
  end
   
end
