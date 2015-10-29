require 'test_helper'

class MassMailerTest < ActionMailer::TestCase
  test "send_to_node" do
    mail = MassMailer.send_to_node
    assert_equal "Send to node", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
