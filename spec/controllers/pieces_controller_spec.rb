require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  it "should successfully create and store a piece" do
    game = Game.create

    piece = Piece.create(x: 3, y: 3, game: game)

    expect(Piece.last.id).to be(piece.id)
  end

end
