require 'rails_helper'

RSpec.describe GamesController, type: :controller do


    it "should successfully test the is_move_valid? method" do
      g = Game.new
      k = King.create(x: 4, y: 3, game: g) 
      expect(k.is_move_valid?(3, 2)).to be(true)
      expect(k.is_move_valid?(2, 2)).to be(false)
      expect(k.is_move_valid?(3, 3)).to be(true)
      expect(k.is_move_valid?(4, 4)).to be(true)
      expect(k.is_move_valid?(4, 6)).to be(false)
      expect(k.is_move_valid?(5, 4)).to be(true)
    end

    it "should successfully determine if piece is obstructed in a horizontal path" do
        g = Game.new
        p = Piece.create(x: 3, y: 3, game: g)
        q = Piece.create(x: 6, y: 3, game: g)
        expect(p.is_obstructed?(7,3)).to be(true)
        expect(p.is_obstructed?(5,3)).to be(false)
    end

    it "should successfully determine if piece is obstructed in a vertical path" do
        g = Game.new
        p = Piece.create(x: 3, y: 3, game: g)
        q = Piece.create(x: 3, y: 6, game: g)
        expect(p.is_obstructed?(3,7)).to be(true)
        expect(p.is_obstructed?(3,5)).to be(false)
    end

    it "should successfully determine if piece is obstructed in a diagonal path" do
        g = Game.new
        p = Piece.create(x: 3, y: 3, game: g)
        q = Piece.create(x: 6, y: 6, game: g)
        expect(p.is_obstructed?(8,8)).to be(true)
        expect(p.is_obstructed?(5,5)).to be(false)
    end

  describe "games#index" do
    it "should successfully show the games/index page" do
      # get :index
      # expect(response).to have_http_status(:success)
    end

    it "should successfully display the pieces on the board" do
      # g = Game.create(:white => 1, :black => 1)
      # expect(g.populate_game!)
    end
  end

  describe "games#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully show 'create a new game' form" do
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
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
      post :create, params: { game: {black: user1, white: user1} }
    
      game = Game.last
      
      expect(game.white).to eq(nil)
      expect(game.black).to eq(user1)
      
    end
  end

  describe "games#update action" do
    it "should allow a second player to join a game" do
      user1 = FactoryGirl.create(:user)
      sign_in user1
      # game = FactoryGirl.create(:game)
      post :create, params: { game: {black: user1, white: user1} }
      # game.reload
      #<Game id: 665, white_user_id: nil, black_user_id: 810>

      user2 = FactoryGirl.create(:user)
      sign_in user2
      game = Game.last
      post :update, params: { id: game.id, game: { white: user2 } }
      game = Game.last
      game.reload
      expect(game.black).to eq(user1)
      # expect(game.white).to eq(user2)
      # expect(response).to redirect_to game_path
    end
  end
end




