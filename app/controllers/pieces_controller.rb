class PiecesController < ApplicationController
  
  def show
    redirect_to game_path(current_piece.game)
  end

  def update
    if game_has_two_players? == false
      flash[:alert]="Waiting for another player" 
    elsif !players_turn
      flash[:alert] = "It is not your turn"
    elsif !players_piece
      flash[:alert] = "That is not your piece"
    else
      result = current_piece.move_to!(piece_params["x"].to_i, piece_params["y"].to_i)
      next_player(current_piece.color) if result == true
    end
    redirect_to game_path(current_piece.game) #temporary, should be done through javascript
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

  def game_has_two_players?
    return true if current_game.black_user_id !=nil && current_game.white_user_id !=nil
    false
  end
   
end
