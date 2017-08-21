class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @games = Game.all
  end

  def create
    @game = Game.create(white_user_id: current_user)
    redirect_to game_path(@game)
  end

  def update

  end

  def show
    @game = current_game
  end


  private

  def current_game
    Game.where(id: params[:id]).last
  end

end
