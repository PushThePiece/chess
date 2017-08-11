require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  it "should successfully test the is_obstructed? method" do
    g = Game.new

    #values are all set to dummy value. Test to be updated as more methods are built.
    p = Piece.new(3,3,g)
    expect(p.is_obstructed?(3,8)).to be(true)

    q = Piece.new(4,8,g)
    expect(q.is_obstructed?(4,6)).to be(true)

    r = Piece.new(1,1,g)
    expect(r.is_obstructed?(5,5)).to be(true)

    t = Piece.new(3,3,g)
    expect(t.is_obstructed?(8,8)).to be(true)
  end
    
end
