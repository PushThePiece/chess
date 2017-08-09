class GamesController < ApplicationController


  
  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)

  def join
    #update current_game.update_attributes(merge:user)???
  end

  private

  # def game_params
  #   params.require(:game).permit(:current_user)
  # end

  def index
  end

  def show
  end

