require 'rails_helper'

RSpec.describe Piece, type: :Pawn do
  before(:example) do
    @g = Game.create
    @p = Pawn.create(x: 3, y: 2, color: "white", game: @g) #white king's bishop's pawn
  end

  describe "valid_move? for Pawn" do
    it "should return false if it is an illegal pawn move" do
      expect(@p.valid_move?(3,6)).to be(false)
    end
  end

  describe "en passant move" do
    it "should return true if move is a valid enpassant" do
      @p.y = 5
      @b = Pawn.create(x:4, y: 5, color: "black", game: @g, passed_thru?: true)
      expect(@p.can_enpassant?(4)).to be(true)
    end

  end

end