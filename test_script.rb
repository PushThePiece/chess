
g = Game.new

p = Piece.new(3,3,g)
puts p.is_obstructed?(3,8)

q = Piece.new(4,8,g)
puts q.is_obstructed?(4,6)

r = Piece.new(1,1,g)
puts r.is_obstructed?(5,5)

t = Piece.new(3,3,g)
puts t.is_obstructed?(8,8)