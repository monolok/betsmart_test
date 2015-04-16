class Datum < ActiveRecord::Base


	def self.send_bet
		open("https://betsmart.herokuapp.com/test")
	end


end
