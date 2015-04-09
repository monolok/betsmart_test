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

def test
	if Bwin.all.empty? != true
		Bwin.all.destroy_all
	end
	#get Bwin URL
	url_bwin = "https://sports.bwin.fr/fr/sports#leagueIds=19328&sportId=4"
	@doc_bwin = Nokogiri::HTML(open(url_bwin))
	@show_bwin = @doc_bwin.at_css("title").text
	# @doc_bwin.css("table").each do |doc|
	# 	@test1 = doc.at_css("tr").text
	# end
	

	#Get Game block and extract team's names and odds
	@hash_bwin = Hash.new
	@c = 0
	@doc_bwin.css("table").each do |g|
		@game_data = g.at_css("tr").text
		@game_data.delete!("\n")
		@game_data.delete!("\r")
		@game_data.strip
		@game_data.delete!(" ")
		@hash_bwin[@c] = @game_data
		@hash_bwin.delete_if {|key, value| value.include?("X") == false }
		#REMOVE ALL NUMBER FROM STRING
		@hash_bwin.each{ |k, v| @hash_bwin[k] = @hash_bwin[k].delete('^a-zA-Z ') }
		@c = @c + 1
	end
	#Record Team Names to DB
	@hash_bwin.values.each do |v|
		home_team_name = v[0..(v.index("X")-1)]
		away_team_name = v[(v.index("X")+1)..v.size]
		Bwin.create(home_team: home_team_name, away_team: away_team_name)
	end


#WITH INCLUDE METHOD ADD ODDS TO Bwin.record by finding Bwin.where(home_team: ?????)

	@hash_bwin_odds = Hash.new
	@c = 0
	@doc_bwin.css("table").each do |g|
		@game_data_odds = g.at_css("tr").text
		@game_data_odds.delete!("\n")
		@game_data_odds.delete!("\r")
		@game_data_odds.strip
		@game_data_odds.delete!(" ")
		@hash_bwin_odds[@c] = @game_data
		@hash_bwin_odds.delete_if {|key, value| value.include?("X") == false }
		@c = @c + 1
	end





# t.decimal  "odd_win_home"
# t.decimal  "odd_draw"
# t.decimal  "odd_win_away"





end

end


#@response = RestClient.get 'https://www.betclic.fr/football/ligue-1-e4' #, {:params => {:id => 50, 'foo' => 'bar'}}	
#@response = @response.code
#RestClient.get 'http://example.com/resource', :params => {:foo => 'bar', :baz => 'qux'}
# will GET http://example.com/resource?foo=bar&baz=qux