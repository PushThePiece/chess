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
    @game = Game.create(black: current_user, white: current_user)
    # Game.create(black: User.last, white: User.last) works in console  
  end

  def update
    @game = Game.find_by_id(params[:id])
    @game.update_attributes(game_params.merge(white: current_user))
    # if @game.white_user_id.present?
    #   black_user_id = user.id
    # else
    #   white_user_id = user.id
    # end
    if @game.valid?
      @game.populate_game!
      redirect_to games_path
    else
      render :new, status: :unprocessable_entity
    end  
  end

  def show
    @game = Game.find(params[:id])
  end


  private

  def game_params
    params.require(:game).permit(:black, :white)
  end

  def game
    @game ||= Game.where(id: params[:id]).last
  end
end
