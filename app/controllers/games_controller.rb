class GamesController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!, only: [:new, :create, :join, :show]
=======
  helper_method :game
>>>>>>> e1a2597ac17477eda3bdc6f54f2cfa06be8c1fae

  def index

  end

  def show
    # @game = Game.find(params[:id])
  end
<<<<<<< HEAD
  
  # def new
  #   @game = Game.new
  # end

  # def create
  #   @game = current_user.games.create(game_params)
  # end

  # def join
  #   #update current_game.update_attributes(merge:user)???
  # end

  # private

  # def game_params
  #   params.require(:game).permit(:current_user)
  # end

=======

  private

  def game
    @game ||= Game.where(id: params[:id]).last
  end
>>>>>>> e1a2597ac17477eda3bdc6f54f2cfa06be8c1fae
end
