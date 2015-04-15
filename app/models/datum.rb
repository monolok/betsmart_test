class Datum < ActiveRecord::Base

	def self.send_bet
		app.get '/test'
	end

end
