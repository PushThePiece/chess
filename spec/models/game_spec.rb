require 'rails_helper'

RSpec.describe Game do

  context 'is created' do
    before(:each) do
      @game = FactoryGirl.create(:game)
    end

    it 'has 32 pieces' do
      expect(@game.pieces.count).to eq(32)
    end

    it 'has no pieces in starting position' do
      (1..8).each do |x|
        (3..6).each do |y|
          expect(@game.pieces.where(x: x, y: y).count).to eq(0)
        end
      end
    end
  end
  
  describe 'check?' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @game.pieces.destroy_all
      
    end

    it 'should return true if the White King is in check' do
      @king = King.create(x: 4, y: 4, color: 'white', game: @game)
      @queen = Queen.create(x: 6, y: 4, color: 'black', game: @game)
      expect(@game.check?(@game.white_user_id)).to eq true
    end

    it 'should return false if White King not in check' do
      @king = King.create(x: 4, y: 4, color: 'white', game: @game)
      @queen = Queen.create(x: 5, y: 6, color: 'black', game: @game)
      expect(@game.check?(@game.white_user_id)).to eq false
    end
  end
end
