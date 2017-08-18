require 'rails_helper'

RSpec.describe Piece, type: :Knight do
  it "should successfully determine if a knight move is valid" do
    g = Game.create
    k = Knight.create(x: 3, y: 3, game: g)
    expect(k.valid_move?(4,5)).to be(true)
    expect(k.valid_move?(5,5)).to be(false)
  end
end

RSpec.describe Piece do
  it "should successfully validate position in the piece table" do
    g = Game.create
    k = Knight.create(x: 10, y: 4, color: "white", game: g)
    expect(k.valid?).to be(false)
  end
end
