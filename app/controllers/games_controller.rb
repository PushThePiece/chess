class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @games = Game.all
  end

  def create
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
    respond_to do |format|
      format.json { render json: @game.pieces }
      format.html
    end
    if current_game.check?(current_game.turn)
      flash[:alert] = "#{current_game.turn} player is in check!"
    end
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
