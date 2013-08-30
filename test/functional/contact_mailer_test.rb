require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "message" do
    mail = Notifications.message
    assert_equal "Message", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "job_application" do
    mail = Notifications.job_application
    assert_equal "Job application", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
