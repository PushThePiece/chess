class Piece < ApplicationRecord
  
  attr_accessor :x, :y

  def initialize(loc_x, loc_y, game)
    @x = loc_x
    @y = loc_y
    @game = game
  end

  def is_obstructed?(dest)

    if is_adjacent?(dest)
      puts "Invalid destination square in is_obstructed: adjacent square"
      return nil
    end

    if is_horizontal?(dest)
      range = (x < dest.x ? (x+1...dest.x) :(dest.x+1...x))
      range.each do |inter_x|
        return true if game.is_occupied?(inter_x, y)
      end
      return false

    elsif is_vertical?(dest)
      range = (y < dest.y ? (y+1...dest.y) :(dest.y+1...y))
      range.each do |inter_y|
        return true if game.is_occupied?(x, inter_y)
      end
      return false

    elsif is_diagonal?(dest)
      range_x = ( (x < dest.x ? (1...dest.x - x) : (1...x - dest.x) ).to_a
      range_y = ( (y < dest.y ? (1...dest.y - y) : (1...y - dest.y) ).to_a
      range_x.size.times do |i|
        return true if game.is_occupied?(x+range_x[i], y+range_y[i])
      end
      return false
      
    else
      puts "Invalid destination square in is_obstructed?"
      return nil
    end
  end

  def is_horizontal?(dest)
    return y == dest.y
  end

  def is_vertical?(dest)
    return x == dest.x
  end

  def is_diagonal?(dest)
    return true if dest.x - x == dest.y - y || dest.x - x == (-1)*(dest.y - y)
    return false
  end

  def is_adjacent?(dest)
    return true if Math.abs((dest.x + dest.y) - (x + y)) == 1
    return false
  end

  def captured?
    x == nil || y == nil
  end

  private
  
  attr_accessor :game

end
