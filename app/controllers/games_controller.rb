class GamesController < ApplicationController
  helper_method :game

  def index
  end

  def show
    
  end

  private

  def game
    @game ||= Game.where(id: params[:id]).last
  end
end
