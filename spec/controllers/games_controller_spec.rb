require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "games#index" do
    it "should successfully show the games#index page" do
      user1 = FactoryGirl.create(:user)
      sign_in user1

      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#create action" do
    it "should require users to be logged in" do
      post :create, params: { game: { user_id: "dummyEmail@gmail.com" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new game" do
      user1 = FactoryGirl.create(:user)
      sign_in user1
      post :create, params: { game: {white_user_id: user1} }
    
      game = Game.last
      
      expect(game.white_user_id).to eq(user1.id)
      expect(response).to redirect_to game_path(game.id)
    end
  end

  describe "games#update action" do
    it "should allow a second player to join a game" do 
      game = FactoryGirl.create(:game)

      user2 = FactoryGirl.create(:user)
      sign_in user2
      put :update, params: { id: game.id, game: { black_user_id: user2.id } }

      game = Game.last
      expect(game.black_user_id).to eq(user2.id)
      expect(response).to redirect_to game_path(game.id)
    end
  end

  describe "games#show action" do
      it "should successfully display the pieces on the board" do
      g = Game.create(:white_user_id => 1, :black_user_id => 1)
      expect(g.populate_game!)
    end
  end
end




