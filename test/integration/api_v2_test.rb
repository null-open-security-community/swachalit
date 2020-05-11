require 'test_helper'

class ApiV2Test < ActionDispatch::IntegrationTest
  test "Public API - Basic test" do
    get '/api-v2/events'
    assert_response :ok

    get '/api-v2/chapters'
    assert_response :ok
  end

  test "Authentications API" do
    post '/api-v2/authentications/password',
      {
        email: 'blah@test.test.com',
        password: 'Test1234',
        client_name: 'Test Client'
      },
      {
        "HTTP_USER_AGENT" => "Test-123"
      }
    assert_response :success
    assert (token = json_response['token'])
    assert json_response['expire_at']

    # get '/api-v2/users/me', {}, { "HTTP_AUTHORIZATION" => "Authorization: Bearer #{token}" }
    # assert_response :ok
  end
end
