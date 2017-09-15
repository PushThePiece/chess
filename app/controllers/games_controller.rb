class GamesController < ApplicationController
  before_action :authenticate_user!
  
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
    @game = Game.create(white_player: current_user, turn: current_user.id, state: 0, winner: nil)
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
      @game = current_game
      #not being used.
      # respond_to do |format|
      #   format.json { render json: @game.pieces }
      #   format.html
      # end
      @player = current_game.player(current_user)
        if current_game.check?(@player)
          flash[:alert] = "#{current_game.player(current_user)} player is in check!"
        end
    else
      return render text: 'Not Allowed', status: :forbidden
    end
  end

  def forfeit
    @player = current_user
    flash[:alert] = "#{@player.email} has forfeited the game."
    @opponent = current_game.opponent(current_user)
    current_game.update_attributes(state: 1)
    # current_game.update_attributes(winner: @opponent)

    redirect_to game_path(current_game)
  end

  def destroy
  end

  private

  def current_game
    Game.where(id: params[:id]).last
  end

end
