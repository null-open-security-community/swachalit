require 'test_helper'

class DeviseConformatinTest < ActionDispatch::IntegrationTest do

  test "Confirmation page requires password" do
    email = 'newuser-fc591ba5dac844d0@example.com'
    name = 'newuser-fc591ba5dac844d0'
  
    post user_registration_path,
      user: { name: nil, email: email, password: 'Test1234', password_confirmation: 'Test1234' }
    
    u = ::User.where(email: email).first()
    token = u.confirmation_token
    get conformations_path, {confirmation_token: token}
    assert_response :success
  end

  test "Confirmation completes after password verification" do
    email = 'newuser-fc591ba5dac844d0@example.com'
    name = 'newuser-fc591ba5dac844d0'
    password = 'Test1234'
  
    post user_registration_path,
      user: { name: nil, email: email, password: password, password_confirmation: password }
    
    u = ::User.where(email: email).first()
    token = u.confirmation_token

    put update_confirmation_path,
      user: {password: password, confirmation_token: token}
    assert_response :success
  end

end