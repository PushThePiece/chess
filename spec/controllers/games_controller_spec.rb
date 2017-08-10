require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  it "should successfully test the is_move_valid? method" do
    g = Game.new
    k = King.new(4,3,g) 
    expect(k.is_move_valid?(3, 2)).to be(false)
    expect(k.is_move_valid?(2, 2)).to be(false)
    expect(k.is_move_valid?(3, 3)).to be(true)
    expect(k.is_move_valid?(4, 4)).to be(true)
    expect(k.is_move_valid?(4, 6)).to be(false)
  end

end
