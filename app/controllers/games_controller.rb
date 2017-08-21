class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @games = Game.all
  end

  def create
    p 'CURRENT USER', current_user
    @game = Game.create(white_user_id: current_user.id)
    redirect_to game_path(@game)
  end

  def update
    current_game.update_attributes(black_user_id: current_user.id)
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
