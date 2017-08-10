class Game < ApplicationRecord
  has_many :pieces
  
  belongs_to :white, class_name: "User", foreign_key: "white_user_id" 
  belongs_to :black, class_name: "User", foreign_key: "black_user_id"

# irb(main):041:0> game = Game.new(white: User.first, black: User.last)
#   User Load (0.2ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
#   User Load (0.3ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT $1  [["LIMIT", 1]]
# => #<Game id: nil, white_user_id: 1, black_user_id: 1>
# irb(main):042:0> game.save
#    (0.4ms)  BEGIN
#   SQL (0.4ms)  INSERT INTO "games" ("white_user_id", "black_user_id") VALUES ($1, $2) RETURNING "id"  [["white_user_id", 1], ["black_user_id", 1]]
#    (0.5ms)  COMMIT
# => true
# irb(main):043:0> game.black
# => #<User id: 1, email: "gretchonian@hotmail.com", created_at: "2017-08-09 17:22:57", updated_at: "2017-08-09 17:22:57">
# irb(main):044:0> game.white
# => #<User id: 1, email: "gretchonian@hotmail.com", created_at: "2017-08-09 17:22:57", updated_at: "2017-08-09 17:22:57">
end
