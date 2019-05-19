require 'test_helper'

class DeviseRegistrationTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  test "New User Registration" do
    email = 'newuser-fc591ba5dac844d0@example.com'
    name = 'newuser-fc591ba5dac844d0'

    post user_registration_path,
      user: { name: name, email: email, password: 'Test1234', password_confirmation: 'Test1234' }
    assert_response :redirect

    u = ::User.where(email: email).first()
    assert !u.nil?
  end

  test "New User Registration Validation Checks" do
    email = 'newuser-fc591ba5dac844d0@example.com'
    name = 'newuser-fc591ba5dac844d0'

    post user_registration_path,
      user: { name: nil, email: email, password: 'Test1234', password_confirmation: 'Test1234' }
    assert_response :success    # 200 OK - Error is rendered

    post user_registration_path,
      user: { name: name, email: email, password: 'Test1234', password_confirmation: 'Test1234' }
    assert_response :redirect   # 302 redirect after successful registration

    post user_registration_path,
      user: { name: name, email: email, password: 'Test1234', password_confirmation: 'Test1234' }
    assert_response :success
  end

  test "Resend confirmation mail" do
    post user_confirmation_path,
      user: { email: 'blah@test.test.com' }
    assert_response :success
  end

end
