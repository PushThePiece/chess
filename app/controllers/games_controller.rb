class GamesController < ApplicationController
  before_action :authenticate_user!
  helper_method :game
  
  def index
    @game = Game.all
  end

  def create
    # new_player = game_params(white: current_user)
    @game = Game.create(black: current_user, white: current_user)
  end

  def update
    new_player = current_user
    @game = current_game.update(game_params.merge(white: new_player)) 
  end

  def show
    @game = current_game
  end


  private

  def current_game
    Game.where(id: params[:id]).last
  end
    
  def game_params
    params.require(:game).permit(:white, :black)
  end

  # def game
  #   @game ||= Game.where(id: params[:id]).last
  # end
end
