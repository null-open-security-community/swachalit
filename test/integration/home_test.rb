require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"] = "1"
    sign_in users(:one)
  end

  teardown do
    ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"] = nil
  end

  test "User visits home page" do
    get root_path
    assert_response :ok
  end

  test "User visits upcoming event page" do
    get upcoming_path
    assert_response :ok
  end

  test "User visits archives page" do
    get archives_path
    assert_response :ok
  end

  test "User visits about page" do
    get about_path
    assert_response :ok
  end

  test "User visits calendar page" do
    get calendar_path
    assert_response :ok
  end

  test "User visits privacy page" do
    get privacy_path
    assert_response :ok
  end

  test "User visits public profile page of existing user" do
    get  public_profile_path(1)
    assert_response :ok
  end

  test "User visits public profile page of non-existent user" do
    assert_raise (ActiveRecord::RecordNotFound) { get public_profile_path(9999) }
  end

  test "User visits raise excepton page" do
    assert_raise { get raise_exception_test_path }
  end

  test "User visits sessions page" do
    get event_sessions_path
    assert_response :ok
  end

  test "User visits forum page" do
    get forum_path
    assert_response :ok
  end
  
end
