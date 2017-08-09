class Game < ApplicationRecord
  belongs_to :white_user_id
  belongs_to :black_user_id
end
