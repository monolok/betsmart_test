# Preview all emails at http://localhost:3000/rails/mailers/sure_bet
class SureBetPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/sure_bet/sure_bet_send
  def sure_bet_send
    SureBet.sure_bet_send
  end

end
