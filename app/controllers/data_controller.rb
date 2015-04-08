class DataController < ApplicationController
require 'open-uri'

def index

	if Datum.all.empty? != true
		Datum.all.destroy_all
	end

#get Betclic URL
	url = "https://www.betclic.fr/football/ligue-1-e4"
	doc = Nokogiri::HTML(open(url))
	@show = doc.at_css("title").text

#Get Game block and extract team's names and odds
	@hash = Hash.new
	doc.css(".CompetitionEvtSpe").each do |g|
		name = g.at_css(".match-name").text
		odd = g.at_css(".match-odds").text
		@hash[name] = odd
		# @game_name = g.at_css(".match-name").text
		# @betfair = g.at_css(".match-odds").text
	end

#strip and chomp data to record in database
	@hash.each do |h|
		teams = h[0]
		team_home = teams[0..(teams.index(" - "))].strip
		team_away = teams[(teams.index(" - "))+2..(teams.size)].strip

		odds = h[1]
		odd_home = (odds[0..31].gsub!(/,/, '').to_f)/100
		odd_draw = (odds[31..62].gsub!(/,/, '').to_f)/100
		odd_away = (odds[62..93].gsub!(/,/, '').to_f)/100

		Datum.create(home: team_home, away: team_away, odd_win_home: odd_home, odd_draw: odd_draw, odd_win_away: odd_away)
	end

	@datum = Datum.all

#Run Surebet calculation and record results to DB
	@datum.each do |game|
		#Surebet result
		result = (1/game.odd_win_home) + (1/game.odd_draw) + (1/game.odd_win_away)
		game.update(surebet: result)
		#surebet draw risk
		highest_two = game.odd_win_home, game.odd_win_away
		result_risk = (1/highest_two.first) + (1/highest_two.last)
		game.update(surebet_risk_draw: result_risk)
		#surebet home-win risk

				# CODE


		#surebet awway-win risk

				# CODE

	end

    # t.string   "home"
    # t.string   "away"
    # t.decimal  "odd_win_home",      precision: 4, scale: 3
    # t.decimal  "odd_draw",          precision: 4, scale: 3
    # t.decimal  "odd_win_away",      precision: 4, scale: 3
    # t.decimal  "surebet",           precision: 4, scale: 3
    # t.decimal  "surebet_risk_draw", precision: 4, scale: 3
    # t.decimal  "surebet_risk_home", precision: 4, scale: 3
    # t.decimal  "surebet_risk_away", precision: 4, scale: 3

	# doc.css(".match-odds").each do |t|
	# 	@test = t.at_css(".odd-button").text
	# end
end

end


# url = "http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=batman&Find.x=0&Find.y=0&Find=Find"
# doc = Nokogiri::HTML(open(url))
# puts doc.at_css("title").text
# doc.css(".item").each do |item|
#   title = item.at_css(".prodLink").text
#   price = item.at_css(".PriceCompare .BodyS, .PriceXLBold").text[/\$[0-9\.]+/]
#   puts "#{title} - #{price}"
#   puts item.at_css(".prodLink")[:href]
# end


#lib/tasks/product_prices.rake 

# desc "Fetch product prices"
# task :fetch_prices => :environment do
#   require 'nokogiri'
#   require 'open-uri'
  
#   Product.find_all_by_price(nil).each do |product|
#     url = "http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=#{CGI.escape(product.name)}&Find.x=0&Find.y=0&Find=Find"
#     doc = Nokogiri::HTML(open(url))
#     price = doc.at_css(".PriceCompare .BodyS, .PriceXLBold").text[/[0-9\.]+/]
#     product.update_attribute(:price, price)
#   end
# end






#@response = RestClient.get 'https://www.betclic.fr/football/ligue-1-e4' #, {:params => {:id => 50, 'foo' => 'bar'}}	
#@response = @response.code
#RestClient.get 'http://example.com/resource', :params => {:foo => 'bar', :baz => 'qux'}
# will GET http://example.com/resource?foo=bar&baz=qux