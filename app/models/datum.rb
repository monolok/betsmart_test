class Datum < ActiveRecord::Base
require 'ping'
	def self.send_bet
		puts "'jimmy' is alive and kicking" if Ping.pingecho('https://betsmart.herokuapp.com/test', 10)
	end

end
