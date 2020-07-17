require 'test_helper'

class UserApiTokenTest < ActiveSupport::TestCase
  test "create user api token" do
    u = users(:one)

    assert_raises { UserApiToken.create_for_user(u, nil, nil, nil) }
  end
end
