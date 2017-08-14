require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  it "should successfully create and store a piece" do
    game = Game.create

    piece = Piece.create(x: 3, y: 3, game: game)

    expect(Piece.last.id).to be(piece.id)
  end

  it "should successfully move to a new square" do
    game = Game.create

    piece1 = Piece.create(x: 3, y: 3, game: game, color: "White")
    piece2 = Piece.create(x: 3, y: 7, game: game, color: "Black")
    piece1.move_to!(3,7)
    piece2.reload

    expect(game.get_piece_at(3,7).id).to eq(piece1.id)
    
    expect(piece2.captured?).to eq(true)
  end


end
