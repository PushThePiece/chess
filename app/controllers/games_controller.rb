class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @game = Game.all
  end

  def create
    @game = Game.create
    redirect_to games_path
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
