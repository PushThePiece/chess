class GamesController < ApplicationController

  before_action :authenticate_user!
  # helper_method :game

  def index
    # @game = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    # Game.create_game(game_params)
    # redirect_to games_path
    # new_player = game_params(current_user)
    @game = Game.create(black: current_user, white: current_user)
    if @game.valid?
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end  
  end

  def join
    @game.populate_game!
    redirect_to games_path
  end

  def show
    @game = Game.find(params[:id])
  end


  private

  def game_params
    params.require(:game).permit(:black)
    params.require(:game).permit(:white_user_id, :black_user_id)
  end

  # def game
  #   @game ||= Game.where(id: params[:id]).last
  # end
end
