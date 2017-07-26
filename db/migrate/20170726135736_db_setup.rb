class DbSetup < ActiveRecord::Migration[5.0]
  def change
    
    create_table :pieces do |t|
      t.integer :type_id
      t.integer :game_id
      t.integer :current_location, array: true
    end

    create_table :piece_types do |t|
      t.string :name
    end

    create_table :games do |t|
      t.integer :white_user_id
      t.integer :black_user_id
    end

  end
end
