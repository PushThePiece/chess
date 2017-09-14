require 'rails_helper'

RSpec.describe Game do

  describe "stalemate:" do
    it "determines if the game is in checkmate when all valid moves lead to check" do
      @g = FactoryGirl.create(:game)
      @g.pieces.destroy_all
      @k = King.create(x: 4, y: 4, color: "white", game: @g)
      @q = Queen.create(x: 2, y: 6, color: "black", game: @g)
      @q = Queen.create(x: 3, y: 4, color: "white", game: @g)
      @b1 = Bishop.create(x: 6, y: 6, color: "black", game: @g)
      @b2 = Bishop.create(x: 5, y: 6, color: "black", game: @g)
      @p2 = Pawn.create(x: 5, y: 4, color: "white", game: @g)
      @p3 = Pawn.create(x: 3, y: 3, color: "white", game: @g)
      @p4 = Pawn.create(x: 4, y: 3, color: "white", game: @g)
      @p5 = Pawn.create(x: 5, y: 3, color: "white", game: @g)
      # expect(@g.stalemate(@k)).to be(true)
    end
  end
  describe "checkmate:" do
    it "determines if the game is not in checkmate as a move out can be created with capture" do

      @g = FactoryGirl.create(:game)
      @g.pieces.destroy_all
      @k = King.create(x: 4, y: 4, color: "white", game: @g)
      @q1 = Queen.create(x: 3, y: 4, color: "white", game: @g)
      @q2 = Queen.create(x: 3, y: 5, color: "black", game: @g)
      @b1 = Bishop.create(x: 4, y: 5, color: "black", game: @g)
      @b2 = Bishop.create(x: 5, y: 5, color: "black", game: @g)
      @p1 = Pawn.create(x: 3, y: 3, color: "white", game: @g)
      @p2 = Pawn.create(x: 4, y: 3, color: "white", game: @g)
      @p3 = Pawn.create(x: 5, y: 3, color: "white", game: @g)
      
      expect(@g.checkmate?(@k)).to be(false)
    end

    it "determines if the game is in checkmate when checkmate is true" do

      @g = FactoryGirl.create(:game)
      @g.pieces.destroy_all
      @k  = King.create(x: 4, y: 4, color: "white", game: @g)
      @q1 = Queen.create(x: 3, y: 4, color: "white", game: @g)
      @q2 = Queen.create(x: 3, y: 5, color: "black", game: @g)
      @b1 = Bishop.create(x: 4, y: 6, color: "black", game: @g)
      @b2 = Bishop.create(x: 5, y: 6, color: "black", game: @g)
      @p1 = Pawn.create(x: 3, y: 3, color: "white", game: @g)
      @p2 = Pawn.create(x: 4, y: 3, color: "white", game: @g)
      @p3 = Pawn.create(x: 5, y: 3, color: "white", game: @g)
      @p4 = Pawn.create(x: 5, y: 4, color: "white", game: @g)
      
      expect(@g.checkmate?(@k)).to be(true)
    end
  end

  context 'is created' do
    before(:each) do
      @game = FactoryGirl.create(:game)
    end

    it 'has 32 pieces' do
      expect(@game.pieces.count).to eq(32)
    end

    it 'has no pieces in starting position' do
      (1..8).each do |x|
        (3..6).each do |y|
          expect(@game.pieces.where(x: x, y: y).count).to eq(0)
        end
      end
    end
  end
  
  describe 'check?' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @game.pieces.destroy_all
      
    end

    it 'should return true if the White King is in check' do
      @king = King.create(x: 4, y: 4, color: 'white', game: @game)
      @queen = Queen.create(x: 6, y: 4, color: 'black', game: @game)
      expect(@game.check?(@game.white_user_id)).to eq true
    end


    it 'should return false if White King not in check' do
      @king = King.create(x: 4, y: 4, color: 'white', game: @game)
      @queen = Queen.create(x: 5, y: 6, color: 'black', game: @game)
      expect(@game.check?(@game.white_user_id)).to eq false
    end
  end
end
