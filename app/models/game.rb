class Game < ApplicationRecord
  has_many :pieces
  belongs_to :white_user_id
  belongs_to :black_user_id
  belongs_to :user
end
