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
    assert (token = json_response['token']) != nil
    assert json_response['expire_at'] != nil

    assert (t = ::UserApiToken.find_by(token: token).presence) != nil
    assert (t.expire_at > Time.now)
    assert (t.active == true)

    get '/api-v2/users/me', {}, { "HTTP_AUTHORIZATION" => "Bearer #{token}" }
    assert_response :ok

    assert json_response['id']
    assert json_response['email']
    assert json_response['name']
    assert json_response['created_at']
    assert json_response['updated_at']
    assert_nil json_response['NANAANA']

    get '/api-v2/users/me', {}, { "HTTP_AUTHORIZATION" => "Bearer 123" }
    assert_response 401
    get '/api-v2/users/me'
    assert_response 401

    t.expire_at = Time.now - 1.minute
    assert t.save

    get '/api-v2/users/me', {}, { "HTTP_AUTHORIZATION" => "Bearer #{token}" }
    assert_response 401

    t.expire_at = Time.now + 100.days
    t.active = false
    assert t.save

    get '/api-v2/users/me', {}, { "HTTP_AUTHORIZATION" => "Bearer #{token}" }
    assert_response 401

    t.active = true
    assert t.save

    get '/api-v2/users/me', {}, { "HTTP_AUTHORIZATION" => "Bearer #{token}" }
    assert_response :ok

    u = t.user
    u.password = u.password_confirmation = 'NewPassword123'
    assert u.save

    get '/api-v2/users/me', {}, { "HTTP_AUTHORIZATION" => "Bearer #{token}" }
    assert_response 401
  end
end
