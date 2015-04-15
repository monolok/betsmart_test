desc "This task is called by the Heroku scheduler add-on"
# task :update_feed => :environment do
#   puts "Updating feed..."
#   NewsFeed.update
#   puts "done."
# end

task :send_bet => :environment do
	puts "Sending e-mail..."
	Datum.send_bet
	puts "done."
end

