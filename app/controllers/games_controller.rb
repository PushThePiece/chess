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
    @game = Game.create(black: current_user, white: current_user)
    if @game.valid?
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end  
  end

  # def join
  #   #update current_game.update_attributes(merge:user)???
  # end

  private

  def game_params
    params.require(:game).permit(black: :current_user)
  end

  # def game
  #   @game ||= Game.where(id: params[:id]).last
  # end
end
