require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"] = "1"
  end

  teardown do
    ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"] = nil
  end

  test "Unauthenticated user can access passsword recovery page" do
    get new_user_password_path
    assert_response :ok
  end

  test "Authenticated users should change password from profile page" do
    sign_in users(:one)
    get new_user_password_path
    assert_redirected_to root_path
  end
end