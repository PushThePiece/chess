class GamesController < ApplicationController
  before_action :authenticate_user!
  helper_method :game
  
  def index
    @game = Game.all
  end

  def new
    @game = Game.new 
  end

  def create
    Game.create(black: current_user)
  end

  def update
    Game.update(white: current_user)
    # if @game.valid?
    # @game.populate_game!
    # redirect_to games_path
    # else
      # render :new, status: :unprocessable_entity
    # end  
  end

  def show
    @game = current_game
  end


  private

  def current_game
    Game.where(id: params[:id]).last
  end
    
  def game_params
    params.require(:game).permit(:white, :black)
  end

  def game
    @game ||= Game.where(id: params[:id]).last
  end
end
