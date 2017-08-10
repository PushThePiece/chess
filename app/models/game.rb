class Game < ApplicationRecord
  has_many :pieces
  
  belongs_to :white, class_name: "User", foreign_key: "white_user_id", 
  belongs_to :black, class_name: "User", foreign_key: "black_user_id"
end
