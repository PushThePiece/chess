class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_player!, only: [:show]

  def index
    @games = Game.active.all
  end

  def create
    # coinflip = Random.new.rand(2)
    # p coinflip
    # if coinflip == 0 
    #   @game = Game.create(white_player: current_user, turn: current_user.id)
    # elsif coinflip == 1 
    #   @game = Game.create(black_player: current_user, turn: current_user.id)
    # end
    @game = Game.create(white_player: current_user, turn: current_user.id, state: 0)
    flash[:alert] = "Waiting for another player to join game."
    redirect_to game_path(@game)
  end

  def update
    current_game.update_attributes(black_player: current_user)
    flash[:alert] = "Let's play!"
    redirect_to game_path(current_game.id)
  end

  def show
    if current_game.active?
      @game=current_game
      #not being used.
      # respond_to do |format|
      #   format.json { render json: @game.pieces }
      #   format.html
      # end
      # @player = @game.player(current_user)
        # if @game.check?(@player)
        #   flash[:alert] = "#{@game.player(current_user)} player is in check!"
        # end
    else
      return render plain: 'Not Allowed', status: :forbidden
    end
  end

  def forfeit
    @player = current_user
    @opponent = current_game.opponent(current_user)
    current_game.update_attributes(state: 1, winner: @opponent)
    # current_game.update_attributes(winner: @opponent)
    flash[:alert] = "#{@player.email} has forfeited the game."
    redirect_to games_path
  end

  private

  helper_method :current_game

  def current_game
    Game.where(id: params[:id]).last
  end

  def authenticate_player!
    current_user == current_game.white_player || current_user == current_game.black_player
  end

end
