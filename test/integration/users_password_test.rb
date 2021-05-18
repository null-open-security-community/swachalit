require 'test_helper'

class UsersPasswordTest < ActionDispatch::IntegrationTest
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
  
    test "Unauthenticated user can not access edit passsword page" do
      get edit_user_password_path
      assert_redirected_to new_user_session_path
    end
    
    test "Authenticated users should change password from profile page only" do
      sign_in users(:one)
      get new_user_password_path
      assert_redirected_to root_path
    end
  
    test "Authenticated users should edit password from profile page only" do
      sign_in users(:one)
      get edit_user_password_path
      assert_redirected_to root_path
    end
  
    #TODO: Do we need to test updates on /users/password?
    # test "Authenticated users can edit password" do
    #   sign_in users(:one)
    #   user = users(:one)
    #   put user_password_path, user:user
    #   assert_response :ok
    # end
end
