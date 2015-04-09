class AddOddsToBwin < ActiveRecord::Migration
  def change
   	add_column :bwins, :odd_win_home, :decimal, precision: 4, scale: 3
	add_column :bwins, :odd_draw, :decimal, precision: 4, scale: 3 	
	add_column :bwins, :odd_win_away, :decimal, precision: 4, scale: 3
  end
end
