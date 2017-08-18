require 'rails_helper'

RSpec.describe Piece, type: :Knight do
  it "should successfully determine if the Knight's move is valid" do
    g = Game.create
    k = Knight.create(x: 3, y: 3, game: g)
    expect(k.valid_move?(4,5)).to be(true)
    expect(k.valid_move?(5,5)).to be(false)
  end
end

RSpec.describe Piece, type: :Bishop do
  it "should successfully determine if the bishop's move is valid" do
    g = Game.create
    b = Bishop.create(x: 3, y: 1, game: g)
    expect(b.valid_move?(4,2)).to be(true)
    expect(b.valid_move?(5,4)).to be(false)
  end
  
RSpec.describe Piece, type: :Rook do
  it "should successfully determine if the Rook's move is valid" do
    g = Game.create
    r = Rook.create(x: 1, y: 1, game: g)
    expect(r.valid_move?(2,2)).to be(false)
    expect(r.valid_move?(1,5)).to be(true)
    expect(r.valid_move?(3,1)).to be(true)
    expect(r.valid_move?(5,5)).to be(false)
  end
  
end