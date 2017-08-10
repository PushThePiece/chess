class Game < ApplicationRecord
  has_many :pieces

  def populate_game!
    Rook.create(game_id: id, current_location: A1)
    Rook.create(game_id: id, current_location: H1)

    end

  end
end
