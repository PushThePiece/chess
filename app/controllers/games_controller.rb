class GamesController < ApplicationController
  before_action :authenticate_user!
  helper_method :game
  attr_accessor :white
  

  def index
    @game = Game.all
  end

  def new
    @game = Game.new 
  end

  def create
    @game = Game.create(black: current_user)
    # Game.create(black: User.last, white: User.last) works in console  
  end

  def update
    # new_player = current_user
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank? 
    @game.update_attributes(game_params)
    # if @game.valid?
    #   @game.populate_game!
    #   redirect_to games_path
    # else
    #   render :new, status: :unprocessable_entity
    # end 
     
  end

  def show
    @game = Game.find(params[:id])
  end


  private

  def game_params
    params.require(:game).permit(:white)
  end

  # def game
  #   @game ||= Game.where(id: params[:id]).last
  # end
end
