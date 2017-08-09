class Piece < ApplicationRecord
  
  attr_accessor :x, :y

  def initialize(loc_x, loc_y, game)
    super()
    @x = loc_x
    @y = loc_y
    @game = game
  end

  def is_obstructed?(dest_x, dest_y)

    if is_adjacent?(dest_x, dest_y)
      puts "Invalid destination square in is_obstructed: adjacent square"
      return nil
    end

    if is_horizontal?(dest_x, dest_y)
      p "horizontal"
      range = (x < dest_x ? (x+1...dest_x) :(dest_x+1...x))
      range.each do |inter_x|
        p "checking square: (#{inter_x},#{y})"
        return true if game.is_occupied?(inter_x, y)
      end
      return false

    elsif is_vertical?(dest_x, dest_y)
      p "vertical"
      range = (y < dest_y) ? (y+1...dest_y) : (dest_y+1...y)
      puts range
      range.each do |inter_y|
        p "checking square: (#{x},#{inter_y})"
        return true if game.is_occupied?(x, inter_y)
      end
      return false

    elsif is_diagonal?(dest_x, dest_y)
      p "diagonal"
      range_x = (x < dest_x ? (1...dest_x - x) : (1...x - dest_x) ).to_a
      range_y = (y < dest_y ? (1...dest_y - y) : (1...y - dest_y) ).to_a
      range_x.size.times do |i|
        return true if game.is_occupied?(x+range_x[i], y+range_y[i])
      end
      return false

    else
      puts "Invalid destination square in is_obstructed?"
      return nil
    end
  end

  def is_horizontal?(dest_x, dest_y)
    return y == dest_y
  end

  def is_vertical?(dest_x, dest_y)
    return x == dest_x
  end

  def is_diagonal?(dest_x, dest_y)
    return true if dest_x - x == dest_y - y || dest_x - x == (-1)*(dest_y - y)
    return false
  end

  def is_adjacent?(dest_x, dest_y)
    return true if ((dest_x + dest_y) - (x + y)).abs == 1
    return false
  end

  def captured?
    x == nil || y == nil
  end

  private
  
  attr_accessor :game

end
