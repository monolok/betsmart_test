class RemoveAndChangeAttributesInData < ActiveRecord::Migration
  def change
  	remove_column :data, :odd_win_home, :integer
  	remove_column :data, :odd_draw, :integer
  	remove_column :data, :odd_win_away, :integer  	
  	add_column :data, :odd_win_home, :decimal, precision: 4, scale: 3
  	add_column :data, :odd_draw, :decimal, precision: 4, scale: 3
  	add_column :data, :odd_win_away, :decimal, precision: 4, scale: 3  	  	
  end
end