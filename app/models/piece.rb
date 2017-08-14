
class Piece < ApplicationRecord


  belongs_to :game

  def move_to!(new_x, new_y)
    p "1"
    if game.is_occupied?(new_x, new_y) == false
      update_attributes(:x => new_x, :y => new_y)
      p "2"
    else
      target_piece = game.get_piece_at(new_x, new_y)
      if target_piece.color == self.color
        p "3"
        # raise error
      else
        if target_piece.type == "King"
          p "4"
          # opponent is in check
          # cannot capture the king
          # raise error
        else
          p "5"
          target_piece.remove_from_game!
          p "6: #{target_piece.x.nil?}"
          update_attributes(:x => new_x, :y => new_y)
          p "7"
        end
      end
    end
  end
  
  def is_obstructed?(dest_x, dest_y)

    if is_adjacent?(dest_x, dest_y)
      puts "Invalid destination square in is_obstructed: adjacent square"
      return nil
    end

    if is_horizontal?(dest_x, dest_y)
      range = (x < dest_x) ? (x+1...dest_x) : (dest_x+1...x)
      range.each do |inter_x|
        return true if game.is_occupied?(inter_x, y)
      end
      return false

    elsif is_vertical?(dest_x, dest_y)
      range = (y < dest_y) ? (y+1...dest_y) : (dest_y+1...y)
      range.each do |inter_y|
        return true if game.is_occupied?(x, inter_y)
      end
      return false

    elsif is_diagonal?(dest_x, dest_y)
      range_x = ( (x < dest_x) ? (1...dest_x - x) : (1...x - dest_x) ).to_a
      range_y = ( (y < dest_y) ? (1...dest_y - y) : (1...y - dest_y) ).to_a
      range_x.size.times do |i|
        return true if game.is_occupied?(x+range_x[i], y+range_y[i])
      end
      return false

    else
      puts "Invalid destination square in is_obstructed?"
      return nil
    end
  end

  def is_horizontal?(_dest_x, dest_y)
    return y == dest_y
  end

  def is_vertical?(dest_x, _dest_y)
    return x == dest_x
  end

  def is_diagonal?(dest_x, dest_y)
    return true if dest_x - x == dest_y - y || dest_x - x == (-1)*(dest_y - y)
    return false
  end

  def is_adjacent?(dest_x, dest_y)
    return true if ((dest_x + dest_y) - (x + y)).abs == 1
    return true if (dest_x - x).abs == 1 && (dest_y - y).abs == 1
    return false
  end

  # Captured piece is denoted by a nil position
  def captured?
    x == nil && y == nil
  end

  def remove_from_game!
    update_attributes(:x => nil, :y => nil)
  end

end
