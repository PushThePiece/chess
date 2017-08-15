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
    new_player = game_params[:black]
    @game = Game.create(black: new_player, white: current_user)
    if @game.valid?
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end  
  end


  private

  def game_params
    params.require(:game).permit(black: :current_user)
  end

  # def game
  #   @game ||= Game.where(id: params[:id]).last
  # end
end
