require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  it "should successfully create and store a piece" do
    game = Game.create

    piece = Piece.create(x: 3, y: 3, game: game)

    expect(Piece.last.id).to be(piece.id)
  end

  it "should successfully move to a new square" do
    game = Game.create

    piece1 = Piece.create(x: 3, y: 3, game: game, color: "white")
    piece2 = Piece.create(x: 3, y: 6, game: game, color: "black")
    piece1.move_to!(3,6)
    piece1.reload
    piece2.reload
    expect(game.get_piece_at(3,6).id).to eq(piece1.id)
    
    expect(piece2.captured?).to eq(true)
  end

  it "should successfully validate the color field" do
    piece = Piece.create(x: nil, y: nil, game: Game.new, color: "purple")
    expect(piece.valid?).to eq(false)
  end

  it "should successfully validate the location to be on the board" do
    piece = Piece.create(x: 10, y: 10, game: Game.new, color: "black")
    expect(piece.valid?).to eq(false)
  end

end
