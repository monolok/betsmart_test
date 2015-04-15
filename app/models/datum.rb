class Datum < ActiveRecord::Base

	def send_bet
		app.get '/test'
	end

end
