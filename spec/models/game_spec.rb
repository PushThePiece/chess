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
      expect(@g.checkmate(@k)).to be(true)
    end
  end
  describe "stalemate for game" do 
    it "determines if the game is in stalemate" do
      @g = Game.new
      @k = King.create(x: 4, y: 4, color: "white", game: @g)
      @p1 = Piece.create(x: 4, y: 3, color: "white", game: @g)
      @p2 = Bishop.create(x: 6, y: 6, color: "black", game: @g)
      @p3 = Piece.create(x: 3, y: 5, color: "white", game: @g)
      @p4 = Piece.create(x: 4, y: 5, color: "white", game: @g)
      @p5 = Piece.create(x: 3, y: 4, color: "white", game: @g)
      @p6 = Piece.create(x: 5, y: 4, color: "white", game: @g)
      @p7 = Piece.create(x: 3, y: 3, color: "white", game: @g)
      @p8 = Piece.create(x: 5, y: 3, color: "white", game: @g)
      # [[5, 5]]
      @g.reload
      # expect(@g.stalemate(@k)).to be(true)
    end

end
