class GamesController < ApplicationController
  helper_method :game

  def index
  end

  def show
    @game = current_game
  end

  private

  def current_game
    Game.where(id: params[:id]).last
  end
end
