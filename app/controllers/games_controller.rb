class GamesController < ApplicationController

  before_action :authenticate_user!
  # helper_method :game

  def index

  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    current_user = game_params[:user]
  end

  # def join
  #   #update current_game.update_attributes(merge:user)???
  # end

  private

  def game_params
    params.require(:game).permit(:user)
  end

  # def game
  #   @game ||= Game.where(id: params[:id]).last
  # end
end
