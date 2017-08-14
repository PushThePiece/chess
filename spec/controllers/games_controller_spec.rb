require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  it "should successfully determine if piece is obstructed in a horizontal path" do
    g = Game.new

    # describe "games#new action" do
    #   it "should require users to be logged in" do
    #     get :new
    #     expect(response).to redirect_to new_user_session_path
    #   end
    #   it "should successfully show the form" do
    #     user = FactoryGirl.create(:user)
    #     sign_in user

    #     get :new
    #     expect(response).to have_http_status(:success)
    #   end
    # end

    # describe "games#create action" do
    #   it "should require users to be logged in" do
    #     post :create, params: {}
    #     expect(response).to ...
    #   end

    #   it "should successfully create a new game" do
    #     user = FactoryGirl.create(:user)
    #     sign_in user

    #     post :create, parmas {}
    #     expect(response).to ...
    #   end
    # end

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

end
