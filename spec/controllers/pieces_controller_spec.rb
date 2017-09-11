require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "turn logic" do
    before(:each) do
      @game = FactoryGirl.create(:game)
    end
    
    it "should not go to next turn on invalid move" do
      before_turn = @game.turn
      @game.get_piece_at(5,2).move_to!(3,3)
      after_turn = @game.turn
      expect(before_turn).to eq(after_turn)
    end

    it "should go to next turn on valid move" do
      before_turn = @game.turn
      @game.get_piece_at(5,2).move_to!(5,4)
      after_turn = @game.turn
      expect(before_turn).to eq(after_turn)
    end
  end
end