class SureBet < ApplicationMailer
 #default from: "postmaster@sandboxc88b1bdd7cf648049b5c49082abc7511.mailgun.org"
   default from: "noreply@antoinebertin.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sure_bet.sure_bet_send.subject
  #
  def sure_bet_send(game_data, size)
  	@game_data = game_data
  	@size = size
    mail to: "antoinebe35@gmail.com"
  end
end

#   @record = Record.new
    
#   if @record.save
#     ModelMailer.new_record_notification(@record).deliver
#     redirect_to @record
#   end

#   @greeting = "Hi there is a new order"
#   @order = order

#   mail to: "antoinebe35@gmail.com"