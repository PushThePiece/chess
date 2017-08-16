class GamesController < ApplicationController
  helper_method :game

  def index
    @game = Game.all
  end

  def create
    Game.create_game(game_params)
    redirect_to games_path
  end

  def join
    @game.populate_game!
    redirect_to games_path
  end

  def show
    @game = current_game
  end

  private

  def current_game
    Game.where(id: params[:id]).last
  end
    
  def game_params
    params.require(:game).permit(:white_user_id, :black_user_id)

  end
end
