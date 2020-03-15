require 'test_helper'
require 'ostruct'

class UserTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  test "ensure api token expires after password change" do
    u = ::User.first
    assert !u.nil?

    req = OpenStruct.new
    req.headers = { }
    req.remote_ip = "192.168.1.100"
    req.user_agent = "Test User Agent"

    token = u.create_api_token("Test Runner", req)
    assert token
    assert token.token.to_s.size > 0

    ft = ::UserApiToken.where(:token => token.token).first()
    assert ft

    assert ft.token == token.token
    assert ft.user.id == u.id

    u.password = u.password_confirmation = "Password123Test123"
    assert u.save

    ft = ::UserApiToken.where(:token => token.token).first()
    assert ft.nil?
  end

  test "ensure confirmation mail is sent" do
    #mc = ::ActionMailer::Base.deliveries.count

    u = ::User.new
    u.name = "Test User for Confirmation Mail"
    u.email = "test-user-confirmation-mail@localhost.local"
    u.password = u.password_confirmation = "Password1234"

    assert u.save
    assert u.confirmation_sent_at
    assert u.confirmation_token.to_s.size > 0

    #assert ::ActionMailer::Base.deliveries.count == (mc + 1)
  end

  test "whitelist in carrierwave uploader" do
    u = ::User.new
    u.name = "User1"
    u.email = "user1@test.local"
    u.password = u.password_confirmation = "Password1234"

    assert u.save

    u.avatar = fixture_file_upload('1.jpg', 'image/jpg')
    assert u.save

    u.avatar = fixture_file_upload('1.html', 'text/html')
    assert !u.save
  end
  
end
