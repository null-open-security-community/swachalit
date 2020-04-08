require 'test_helper'

class ApiV2Test < ActionDispatch::IntegrationTest
  test "Public API - Basic test" do
    get '/api-v2/events'
    assert_response :ok

    get '/api-v2/chapters'
    assert_response :ok
  end
end