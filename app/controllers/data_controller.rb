class DataController < ApplicationController
require 'open-uri'

def index

	#get URL
	url = "http://www.coteur.com/surebet.php"
	doc = Nokogiri::HTML(open(url))
	@show = doc.at_css("title").text

	@test = doc.css('tfoot').text
	if @test = "Pas de surebet en ce moment"
		@test1 = false
	end

	

end

def test
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
		no_draw = game.odd_win_home, game.odd_win_away
		result_risk = (1/no_draw.first) + (1/no_draw.last)
		game.update(surebet_risk_draw: result_risk)
		#surebet home-win risk
		no_home_win = game.odd_draw, game.odd_win_away
		result_risk2 = (1/no_home_win.first) + (1/no_home_win.last)
		game.update(surebet_risk_home: result_risk2)
		#surebet awway-win risk
		no_away_win = game.odd_draw, game.odd_win_home
		result_risk3 = (1/no_away_win.first) + (1/no_away_win.last)
		game.update(surebet_risk_away: result_risk3)
	end
end


#MAILER MAILER EXEMPLE

# def create
#   @record = Record.new
    
#   if @record.save
#     ModelMailer.new_record_notification(@record).deliver
#     redirect_to @record
#   end
# end

# def new_order(order)
#   # @greeting = "Hi there is a new order"
#   @order = order

#   mail to: "antoinebe35@gmail.com"
# end

end


#@response = RestClient.get 'https://www.betclic.fr/football/ligue-1-e4' #, {:params => {:id => 50, 'foo' => 'bar'}}	
#@response = @response.code
#RestClient.get 'http://example.com/resource', :params => {:foo => 'bar', :baz => 'qux'}
# will GET http://example.com/resource?foo=bar&baz=qux