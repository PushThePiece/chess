
class Piece < ApplicationRecord


  belongs_to :game

  validates :color, inclusion: { in: ['white', 'black'] }, :allow_nil => true
  validates :x, numericality: { greater_than: 0, less_than: 9}, :allow_nil => true
  validates :y, numericality: { greater_than: 0, less_than: 9}, :allow_nil => true

  def move_to!(new_x, new_y)
    
    return false if valid_move?(new_x, new_y) == false #invalid move

    if game.is_occupied?(new_x, new_y) == false
      update_attributes(:x => new_x, :y => new_y)
    else
      target_piece = game.get_piece_at(new_x, new_y)
      
      return false if target_piece.color == self.color #can't move to square with piece of own color
      
      return false if target_piece.type == "King" #can't capture the opponent's king
      # this should never happen because they should have moved out of check last turn
      
      target_piece.remove_from_game!
      update_attributes(:x => new_x, :y => new_y)
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
    dest_x - x == dest_y - y || dest_x - x == (-1)*(dest_y - y)
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


  def coord_to_alg_notation(x, y)
    alg = ""
    case x
    when 1
      alg = "A"
    when 2
      alg = "B"
    when 3
      alg = "C"
    when 4
      alg = "D"
    when 5
      alg = "E"
    when 6
      alg = "F"
    when 7
      alg = "G"
    when 8
      alg = "H"
    end
    alg += y.to_s

    alg
  end
end
