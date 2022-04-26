require 'test_helper'

class DeviseConformatinTest < ActionDispatch::IntegrationTest

  test "Confirmation page requires password" do
    email = 'newuser-fc591ba5dac844d0@example.com'
    name = 'newuser-fc591ba5dac844d0'
  
    post user_registration_path,
      user: { name: name, email: email, password: 'Test1234', password_confirmation: 'Test1234' }
    assert_response :redirect
    
    u = ::User.where(email: email).first()
    token = u.confirmation_token

    get '/users/confirmation', {confirmation_token: token}
    assert_response :success

    u = ::User.where(email: email).first()
    assert_not u.confirmed?
  end

  test "Confirmation completes after password verification" do
    email = 'newuser-fc591ba5dac844d0@example.com'
    name = 'newuser-fc591ba5dac844d0'
    password = get_random_string
  
    post user_registration_path,
      user: { name: name, email: email, password: password, password_confirmation: password }
    assert_response :redirect

    u = ::User.where(email: email).first()
    token = u.confirmation_token

    put confirm_with_password_path,
      user: {password: password, confirmation_token: token}
    assert_redirected_to new_user_session_path

    u = ::User.where(email: email).first()
    assert u.confirmed?
  end

  test "Confirmation fails on incorrect password" do
    email = 'newuser-fc591ba5dac844d0@example.com'
    name = 'newuser-fc591ba5dac844d0'
    password = get_random_string()
    
    post user_registration_path,
      user: { name: name, email: email, password: password, password_confirmation: password }
    assert_response :redirect

    u = ::User.where(email: email).first()
    token = u.confirmation_token

    put confirm_with_password_path,
      user: {password: 'WrongPass', confirmation_token: token}
    assert_redirected_to "/users/confirmation?confirmation_token=#{token}"

    u = ::User.where(email: email).first()
    assert_not u.confirmed?
  end

end
