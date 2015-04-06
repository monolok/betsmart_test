class DataController < ApplicationController
require 'open-uri'

def index
	url = "https://www.betclic.fr/football/ligue-1-e4"
	doc = Nokogiri::HTML(open(url))
	@show = doc.at_css("title").text


	@hash = Hash.new
	doc.css(".CompetitionEvtSpe").each do |g|
		name = g.at_css(".match-name").text
		odd = g.at_css(".match-odds").text
		@hash[name] = odd
		# @game_name = g.at_css(".match-name").text
		# @betfair = g.at_css(".match-odds").text
	end

	@odds = Array.new
	@hash.each do |h|
		@odds.push(h[1]) #string of 3 odds
	end

# 	 t.string   "home"
#    t.string   "away"
#    t.integer  "odd_win_home"
#    t.integer  "odd_draw"
#    t.integer  "odd_win_away"

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