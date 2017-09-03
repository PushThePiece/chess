require 'rails_helper'

RSpec.describe Piece, type: :King do

  before(:example) do
    @g = Game.create
    @k = King.create(x: 4, y: 4, color: "white", game: @g)
  end

  describe "fake_moves for King" do
    it "should return true if King has a valid move" do
      b = Piece.create(x: 3, y: 5, color: "white", game: @g)
      b = Piece.create(x: 4, y: 5, color: "white", game: @g)
      b = Piece.create(x: 5, y: 5, color: "white", game: @g)
      b = Piece.create(x: 3, y: 4, color: "white", game: @g)
      b = Piece.create(x: 5, y: 4, color: "white", game: @g)
      b = Piece.create(x: 3, y: 3, color: "white", game: @g)
      b = Piece.create(x: 4, y: 3, color: "white", game: @g)
      b = Piece.create(x: 5, y: 3, color: "black", game: @g)
      expect(@k.fake_moves).to be(false)
    end

    it "should return true if King has a valid move" do
      b = Bishop.create(x: 3, y: 5, color: "black", game: @g)
      b = Bishop.create(x: 4, y: 5, color: "black", game: @g)
      b = Bishop.create(x: 5, y: 5, color: "black", game: @g)
      b = Bishop.create(x: 3, y: 4, color: "black", game: @g)
      expect(@k.fake_moves).to be(true)
    end
  end

  describe "valid_move? for King" do
    it "should return false if it is an illegal king move" do
      expect(@k.valid_move?(3,6)).to be(false)
    end
  end

  describe "castling" do
    it "should return false if a piece is obstructing the castling" do
      @k.update_attributes(x: 5, y: 1)
      r = Rook.create(x: 8, y: 1, color: "white", game: @g)
      b = Bishop.create(x: 6, y: 1, color: "white", game: @g)
      expect(@k.move_to!(7,1)).to be(false) #attempt to castle
      b.remove_from_game!
    end

    it "should return false if castling through opponent's attacking range" do
      @k.update_attributes(x: 5, y: 1)
      r = Rook.create(x: 8, y: 1, color: "white", game: @g)
      kn = Knight.create(x: 5, y: 3, color: "black", game: @g)
      @g.get_piece_at(6,1).remove_from_game!
      @g.get_piece_at(7,1).remove_from_game!
      expect(@k.move_to!(7,1)).to be(false) #attempt to castle
    end
  end
end




  # it "should successfully kingside castle with the white king according to the rules of chess" do
  #   game = Game.create
  #   game.get_piece_at(6,1).remove_from_game!
  #   game.get_piece_at(7,1).remove_from_game!
  #   king = game.pieces.where(type: "King", color: "white").last
  #   rook = game.pieces.where(type: "Rook", color: "white", x: 8).last
  #   expect(king.move_to!(7, 1)).to be(true) #castle
  #   expect(rook.x).to eq(6)
  #   expect(king.has_moved?).to be(true)
  #   expect(rook.has_moved?).to be(true)

  # end

  # it "should successfully queenside castle with the white king according to the rules of chess" do
  #   game = Game.create
  #   game.get_piece_at(2,1).remove_from_game!
  #   game.get_piece_at(3,1).remove_from_game!
  #   game.get_piece_at(4,1).remove_from_game!
  #   king = game.pieces.where(type: "King", color: "white").last
  #   expect(king.castle!(8,1)).to be(true)
  #   expect(king.x).to eq(3)
  #   expect(king.has_moved?).to be(true)
  # end

  # it "should successfully kingside castle with the black king according to the rules of chess" do
  #   game = Game.create
  #   game.get_piece_at(6,8).remove_from_game!
  #   game.get_piece_at(7,8).remove_from_game!
  #   king = game.pieces.where(type: "King", color: "black").last
  #   expect(king.castle!(8,1)).to be(true)
  #   expect(king.x).to eq(7)
  #   expect(king.has_moved?).to be(true)
  # end

  # it "should fail to castle if obstructed" do
  #   game = Game.create
  #   game.get_piece_at(6,1).remove_from_game!
  #   king = game.pieces.where(type: "King", color: "white").last
  #   expect(king.castle!(8,1)).to be(false)
  #   expect(king.x).to eq(5)
  #   expect(king.has_moved?).to be(false)
  # end
  # end