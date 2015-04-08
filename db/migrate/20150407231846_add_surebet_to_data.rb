class AddSurebetToData < ActiveRecord::Migration
  def change
  	  add_column :data, :surebet, :decimal, precision: 4, scale: 3
  end
end
