every 1.day, :at => '4:30 am' do
	command "curl http://localhost:3000", :environment => 'development'
    #runner "Datum.index", :environment => 'development'
end

#whenever -w

#crontab -l
