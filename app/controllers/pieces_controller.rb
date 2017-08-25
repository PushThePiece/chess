class PiecesController < ApplicationController
  def show
    @piece = Piece.find(params[:id])
    @current_game = current_game
    redirect_to game_path(@piece.game)
  end

  def update
    @piece = Piece.find(params[:id])
    @piece.update_attributes(piece_params)
    render json: @piece
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
