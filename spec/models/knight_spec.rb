require 'rails_helper'

RSpec.describe Piece, type: :Knight do

  before(:example) do
    @g = Game.create
    @k = Knight.create(x: 3, y: 3, color: "white", game: @g)
  end

  describe "valid_move? for knight" do
    it "should return false if it is an illegal knight move" do
      expect(@k.valid_move?(3,5)).to be(false)
    end
  end

end


