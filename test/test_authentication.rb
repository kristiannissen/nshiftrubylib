require "minitest/autorun"
require "authentication"

require "test_helper"

class AuthenticationTest < Minitest::Test
  
  def test_get_access_token
    assert_equal(Authentication.get_access_token.has_key?("access_token"), true)
  end

  def test_has_token_expired
    assert_equal(Authentication.has_token_expired?, true)
  end
end
