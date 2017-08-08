class Piece < ApplicationRecord
  
  attr_accessor :x, :y

  def initialize(loc_x, loc_y)
    @x = loc_x
    @y = loc_y
  end

  def is_obstructed?(dest)
    if is_horizontal?(dest)
      range = (x+1...dest.x)
      range.each do |inter_x|
        return true if game.is_occupied?(inter_x, y)
      end
      return false
    elsif is_vertical?(dest)
      range = (y+1...dest.y)
      range.each do |inter_y|
        return true if game.is_occupied?(x, inter_y)
      end
      return false
    elsif is_diagonal?(dest)
      if dest.x - x == dest.y - y
        range = (1...dest.x)
        range.each do |inter_diag|
          return true if game.is_occupied?(x+inter_diag, y+inter_diag)
        end
        return false
      elsif dest.x - x == (-1)*(dest.y - y)
        range = (1...dest.x)
        range.each do |inter_diag|
          return true if game.is_occupied?(x+inter_diag, y-inter_diag)
        end
        return false
      end
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
    return true if dest.x - x == dest.y - y
    return true if dest.x - x == (-1)*(dest.y - y)
    return false
  end

end
