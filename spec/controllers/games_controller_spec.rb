require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  it "should successfully determine if piece is obstructed in a horizontal path" do
    g = Game.new

    p = Piece.create(x: 3, y: 3, game: g)
    q = Piece.create(x: 6, y: 3, game: g)
    
    expect(p.is_obstructed?(7,3)).to be(true)

    expect(p.is_obstructed?(5,3)).to be(false)

  end

  it "should successfully determine if piece is obstructed in a vertical path" do
    g = Game.new

    p = Piece.create(x: 3, y: 3, game: g)
    q = Piece.create(x: 3, y: 6, game: g)
    
    expect(p.is_obstructed?(3,7)).to be(true)
    expect(p.is_obstructed?(3,5)).to be(false)

  end

  it "should successfully determine if piece is obstructed in a diagonal path" do
    g = Game.new

    p = Piece.create(x: 3, y: 3, game: g)
    q = Piece.create(x: 6, y: 6, game: g)
    
    expect(p.is_obstructed?(8,8)).to be(true)

    expect(p.is_obstructed?(5,5)).to be(false)

  end

end