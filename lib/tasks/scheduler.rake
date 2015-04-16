desc "This task is called by the Heroku scheduler add-on"
# task :update_feed => :environment do
#   puts "Updating feed..."
#   NewsFeed.update
#   puts "done."
# end

task :send_bet => :environment do
	puts "Sending e-mail..."
	Datum.send_bet
	
	if Datum.all.count >= 1
		#Datum.create(home: @game_data)
		@data_game = Array.new
		Datum.all.each do |d|
			@data_game.push(d.home)
		end
		SureBet.sure_bet_send(@data_game, @size).deliver_now
		puts "done."
		Datum.all.destroy_all
		puts "Data deleted"
	else
		puts "no surebet."
	end
	#sh "https://betsmart.herokuapp.com/test"

end

