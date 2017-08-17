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
    @game = Game.create(black: current_user)
    # Game.create(black: User.last, white: User.last) works in console  
  end

  def update
    new_player = current_user
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank? 
    @game.update_attributes(white: new_player)
    # if @game.valid?
    #   @game.populate_game!
    #   redirect_to games_path
    # else
    #   render :new, status: :unprocessable_entity
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
