require 'rails_helper'

RSpec.describe Piece, type: :Bishop do

  before(:example) do
    @g = Game.create
    @b = Bishop.create(x: 3, y: 3, color: "white", game: @g)
  end

  describe "valid_move? for bishop" do
    it "should return false if it is an illegal bishop move" do
      expect(@b.valid_move?(3,4)).to be(false)
    end
  end

end


