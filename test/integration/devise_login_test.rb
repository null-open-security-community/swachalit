require 'test_helper'

class DeviseLoginTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  test "Devise user sign-in" do
    get new_user_session_path
    assert_response :success

    post user_session_path,
      user: { email: 's@s.com', password: 'test123' }
    assert_response :success

    user = 'blah@test.test.com'
    password = 'Test1234'

    u = ::User.where(:email => user).first()
    assert u
    assert u.valid_password? password

    post user_session_path,
      user: { email: user, password: password }
    
    assert_response :redirect
  end

  test "Access post-auth page" do
    user = users(:one)

    get edit_user_registration_path(user)
    assert_response :unauthorized

    login_as user, :scope => :user

    get edit_user_registration_path(user)
    assert_response :success
  end

  test "Ensure all post auth page require authentication" do
    get new_session_request_path
    assert_response :redirect

    get new_session_proposal_path
    assert_response :redirect
  end
end
