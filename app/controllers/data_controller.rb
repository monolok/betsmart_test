class DataController < ApplicationController
require 'open-uri'

	def index
	end


	def test
		
		#get URL
		url = "http://www.coteur.com/surebet.php"
		doc = Nokogiri::HTML(open(url))
		@show = doc.at_css("title").text

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