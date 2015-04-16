class Datum < ActiveRecord::Base
require 'open-uri'

	def self.send_bet

		#get URL
		url = "http://www.coteur.com/surebet.php"
		doc = Nokogiri::HTML(open(url))
		@show = doc.at_css("title").text

		@game_data = Array.new
		doc.css('tbody').each do |tr|
			tr.css("tr").each do |f|
				@game_data.push(f.css("td").text)
				Datum.create(home: @game_data)
			end
		end

	end


end