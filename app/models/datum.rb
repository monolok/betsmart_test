class Datum < ActiveRecord::Base
require 'open-uri'

	def self.send_bet
	#open("https://betsmart.herokuapp.com/test")
		url = "http://www.coteur.com/surebet.php"
		doc = Nokogiri::HTML(open(url))

		@game_data = Array.new
		doc.css('tbody').each do |tr|
			tr.css("tr").each do |f|
				@game_data.push(f.css("td").text)
			end
		end

		@size = @game_data.size
		if @size >= 1
			SureBet.sure_bet_send(@game_data, @size).deliver_now
		end
		
	end


end