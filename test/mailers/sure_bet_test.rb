require 'test_helper'

class SureBetTest < ActionMailer::TestCase
  test "sure_bet_send" do
    mail = SureBet.sure_bet_send
    assert_equal "Sure bet send", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
