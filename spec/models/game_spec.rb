require 'rails_helper'

RSpec.describe Game, type: :model do



  describe "checkmate for game" do
    it "determines if the game is in checkmate" do
      @g = Game.new
      @k = King.create(x: 4, y: 4, color: "white", game: @g)
      @q = Queen.create(x: 4, y: 3, color: "black", game: @g)
      @b = Bishop.create(x: 6, y: 6, color: "black", game: @g)
      @p1= Piece.create(x: 1, y: 6, color: "black", game: @g)
      # [[3, 3], [4, 3], [5, 3], [3, 4], [5, 4], [3, 5], [4, 5], [5, 5]]
      @g.reload
      # expect(@g.checkmate?(@k)).to be(true)
    end
  end
  describe "stalemate for game" do 
    it "determines if the game is in stalemate" do
      @g = Game.new
      @k = King.create(x: 4, y: 4, color: "white", game: @g)
      @p1 = Piece.create(x: 4, y: 3, color: "white", game: @g)
      @p2 = Bishop.create(x: 6, y: 6, color: "black", game: @g)
      # @p3 = Piece.create(x: 3, y: 5, color: "white", game: @g)
      @p4 = Piece.create(x: 4, y: 5, color: "white", game: @g)
      @p5 = Piece.create(x: 3, y: 4, color: "white", game: @g)
      @p6 = Piece.create(x: 5, y: 4, color: "white", game: @g)
      @p7 = Piece.create(x: 3, y: 3, color: "white", game: @g)
      @p8 = Piece.create(x: 5, y: 3, color: "white", game: @g)
      # [[3,5], [5, 5]]
      @g.reload
      # expect(@g.stalemate(@k)).to be(true)
    end
  end

  context 'is created' do
    before(:each) do
      @game = Game.create
    end

    it 'has 32 pieces' do
      expect(@game.pieces.count).to eq 32
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
        @game = Game.create
        @king = King.new(x: 4, y: 4, color: 'white')
        @queen = Queen.new(x: 6, y: 4, color: 'white')
      end

      it 'false if White King in check' do
        
        @game.pieces << @queen
        @game.pieces << @king

        expect(@game.check?('white')).to eq false
      end
    end


end
