require 'rails_helper'

RSpec.describe Piece, type: :King do

# <<<<<<< HEAD
#   describe "valid_moves for king" do
#   it "determines if the king has valid_moves while in check" do
#     @g = Game.new
#     @k = King.create(x: 4, y: 4, color: "white", game: @g)
#     @q = Queen.create(x: 4, y: 3, color: "black", game: @g)
#     @b = Bishop.create(x: 6, y: 6, color: "black", game: @g)
#     @p1= Piece.create(x: 1, y: 6, color: "black", game: @g)
#     #[]
#     # [[3, 3], [4, 3], [5, 3], [3, 4], [5, 4], [3, 5], [4, 5], [5, 5]]
#     @g.reload
#     # expect(@k.valid_moves?).to be(true)
#   end
# end

#   before(:example) do
#     @g = Game.create
#     @k = King.create(x: 4, y: 4, color: "white", game: @g)
#   end

#   describe "valid_move? for King do" do
#     it "should return false if it is an illegal king move" do
#       expect(@k.valid_move?(3,6)).to be(false)
#     end

#     it "should return false if it is an illegal king move" do
#       # expect(@k.valid_move?(4,3)).to be(true)
#     end

#     it "should return false if it is an illegal king move" do
#       # expect(@k.valid_move?(3,4)).to be(true)
# =======
  before(:each) do
    @g = FactoryGirl.create(:game)
    @k = King.create(x: 4, y: 4, color: "white", game: @g)
  end

  describe "valid_move? for King" do
    it "should return false if it is an invalid king move" do
      expect(@k.valid_move?(3,6)).to be(false)
    end

    it "should return false if king doesn't move out of check" do
      Rook.create(x: 4, y: 6, color: "black", game: @g)
      expect(@k.move_to!(4,5)).to be(false) # still in check
      expect(@k.move_to!(5,4)).to be(true) # moves out of check
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
      kn = Knight.create(x: 5, y: 3, color: "black", game: @g) #attacking (6,1)
      @g.get_piece_at(6,1).remove_from_game! if !@g.get_piece_at(6,1).nil? #no obstructions
      @g.get_piece_at(7,1).remove_from_game! if !@g.get_piece_at(7,1).nil?
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