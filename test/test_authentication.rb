require "minitest/autorun"
require "authentication"
require "storage"
require "test_helper"

class AuthenticationTest < Minitest::Test
  
  def test_get_access_token
    # Consig the storage
    Storage.config.folder = "./tmp"

    assert_equal(Authentication.get_access_token(&Storage::method(:set)).has_key?("access_token"), true)
  end

  def test_access_token_exception
    e = assert_raises(RuntimeError) do
      Authentication.get_access_token()
    end

    assert_equal(/callback/.match?(e.message), true)
  end

  def test_has_token_expired
    assert_equal(Authentication.has_token_expired?, true)
  end
end
