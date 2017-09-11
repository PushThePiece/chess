class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @games = Game.all
  end

  def create
    # coinflip = Random.new.rand(2)
    # p coinflip
    # if coinflip == 0 
    #   @game = Game.create(white_player: current_user, turn: current_user.id)
    # elsif coinflip == 1 
    #   @game = Game.create(black_player: current_user, turn: current_user.id)
    # end
    @game = Game.create(white_player: current_user, turn: current_user.id)
    flash[:alert] = "Waiting for another player to join game."
    redirect_to game_path(@game)
  end

  def update
    current_game.update_attributes(black_player: current_user)
    flash[:alert] = "Let's play!"
    redirect_to game_path(current_game.id)
  end

  def show
    @game = current_game
  end

  def forfeit
    current_game.forfeit!(current_user)
    flash[:alert] = "You have forfeited the game."
    redirect_to games_path
  end

  private

  def current_game
    Game.where(id: params[:id]).last
  end

end
