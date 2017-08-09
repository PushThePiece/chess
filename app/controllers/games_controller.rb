class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :join, :show]

  def index

  end

  def show

  end
  
  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
  end

  def join
    #update current_game.update_attributes(merge:user)???
  end

  private

  # def game_params
  #   params.require(:game).permit(:current_user)
  # end

end
