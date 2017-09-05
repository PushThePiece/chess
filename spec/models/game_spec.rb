require 'rails_helper'

RSpec.describe Game, type: :model do

  context 'is created' do
    before(:each) do
      @game = Game.create
    end

    it 'has 32 pieces' do
      expect(@game.pieces.count).to eq 32
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
        @game = Game.create
        @king = King.new(x: 4, y: 4, color: 'white')
        @queen = Queen.new(x: 6, y: 4, color: 'white')
      end

      it 'false if White King in check' do
        
        @game.pieces << @queen
        @game.pieces << @king

        expect(@game.check?('white')).to eq false
      end
    end

end
