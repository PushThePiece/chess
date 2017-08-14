class GamesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :join, :show]

  helper_method :game

  def index

  end

  def show
    # @game = Game.find(params[:id])
  end

  
  # def new
  #   @game = Game.new
  # end

  # def create
  #   @game = current_user.games.create(game_params)
  # end

  # def join
  #   #update current_game.update_attributes(merge:user)???
  # end

  # private

  # def game_params
  #   params.require(:game).permit(:current_user)
  # end

  private

  def game
    @game ||= Game.where(id: params[:id]).last
  end
end
