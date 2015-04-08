class AddSurebetRiskToData < ActiveRecord::Migration
  def change
   	add_column :data, :surebet_risk_draw, :decimal, precision: 4, scale: 3
	add_column :data, :surebet_risk_home, :decimal, precision: 4, scale: 3 	
	add_column :data, :surebet_risk_away, :decimal, precision: 4, scale: 3 	 	
  end
end