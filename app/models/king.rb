class King < Piece

  def is_move_valid?(dest_x, dest_y) 
    is_adjacent?(dest_x, dest_y)
  end

  def castle_kingside!
    return false if has_moved?

    if color == "white" 
      corner_piece = game.get_piece_at(8,1)
      if corner_piece.type == "Rook" && corner_piece.has_moved? == false
        if !game.is_occupied?(7,1) && !game.is_occupied?(6,1)
          #do castle
          update_attributes(:x => 7,:y => 1, :has_moved? => true)
          corner_piece.update_attributes!(:x => 6, :y => 1, :has_moved? => true)
          return true
        end
      end

    elsif color == "black"
      corner_piece = game.get_piece_at(8,8)
      if corner_piece.type == "Rook" && corner_piece.has_moved? == false
        if !game.is_occupied?(7,8) && !game.is_occupied?(6,8)
          #do castle
          update_attributes(:x => 7,:y => 8, :has_moved? => true)
          corner_piece.update_attributes!(:x => 6, :y => 8, :has_moved? => true)
          return true
        end
      end
    end

    return false
  end

  def unicode_point
    color == 'white' ? '&#9812' : '&#9818'
  end
end