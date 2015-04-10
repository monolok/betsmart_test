class SureBet < ApplicationMailer
 default from: "postmaster@sandboxc88b1bdd7cf648049b5c49082abc7511.mailgun.org"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sure_bet.sure_bet_send.subject
  #
  def sure_bet_send
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
