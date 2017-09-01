class PiecesController < ApplicationController
  def show
    @piece = Piece.find(params[:id])
    @current_game = current_game
    redirect_to game_path(@piece.game)
  end

  def update
    @piece = Piece.find(params[:id])
    # if @piece.user_id == current_game.turn
        #if @piece.valid_move?(dest_x, dest_y)
        @piece.update_attributes(piece_params)
        current_game.next_player(@piece.color)
        render json: @piece
        #end
    # end
  end

  private 

  helper_method :current_game

  def current_game
    @piece = Piece.find(params[:id])
    @current_game ||= @piece.game
  end

  def piece_params
    params.require(:piece).permit(:x, :y)
  end

end
