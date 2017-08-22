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

    it "should successfully test the is_move_valid? method" do
      g = Game.new
      k = King.create(x: 4, y: 3, game: g) 
      expect(k.is_move_valid?(3, 2)).to be(true)
      expect(k.is_move_valid?(2, 2)).to be(false)
      expect(k.is_move_valid?(3, 3)).to be(true)
      expect(k.is_move_valid?(4, 4)).to be(true)
      expect(k.is_move_valid?(4, 6)).to be(false)
      expect(k.is_move_valid?(5, 4)).to be(true)
    end

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
