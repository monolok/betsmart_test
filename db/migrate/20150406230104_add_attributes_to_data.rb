class AddAttributesToData < ActiveRecord::Migration
  def change
  	add_column :data, :home, :string
  	add_column :data, :away, :string
  	add_column :data, :odd_win_home, :integer
  	add_column :data, :odd_draw, :integer
  	add_column :data, :odd_win_away, :integer  	  	
  end
end
