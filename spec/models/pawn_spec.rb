require 'rails_helper'

RSpec.describe Piece, type: :Pawn do
  before(:example) do
    @g = Game.create
    @p = Pawn.create(x: 3, y: 2, game: @g) #white king's bishop's pawn
  end

  describe "valid_move? for Pawn" do
    it "should return false if it is an illegal pawn move" do
      expect(@p.valid_move?(3,6)).to be(false)
    end
  end
end