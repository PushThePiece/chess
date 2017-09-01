class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @games = Game.all
  end

  def create
    @game = Game.create(white_user_id: current_user.id, turn: current_user.id)
    @game.set_pieces_to_user_color
    flash[:alert] = "Waiting for another player to join game."
    redirect_to game_path(@game)
  end

  def update
    current_game.update_attributes(black_user_id: current_user.id)
    flash[:alert] = "Let's play!"
    redirect_to game_path(current_game.id)
  end

  def show
    @game = current_game
  end


  private

  def current_game
    Game.where(id: params[:id]).last
  end

end
