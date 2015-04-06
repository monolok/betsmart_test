class DataController < ApplicationController

def index
	@response = RestClient.get 'https://www.betclic.fr/football/ligue-1-e4' #, {:params => {:id => 50, 'foo' => 'bar'}}	
	@response = @response.code
end

end

#RestClient.get 'http://example.com/resource', :params => {:foo => 'bar', :baz => 'qux'}
# will GET http://example.com/resource?foo=bar&baz=qux