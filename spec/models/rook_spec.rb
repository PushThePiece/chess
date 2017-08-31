require 'rails_helper'

RSpec.describe Piece, type: :Rook do

  before(:example) do
    @g = Game.create
    @r = Rook.create(x: 3, y: 3, color: "white", game: @g)
  end

  describe "valid_move? for rook" do
    it "should return false if it is an illegal rook move" do
      expect(@r.valid_move?(4,5)).to be(false)
    end
  end

end


