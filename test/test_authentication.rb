require "minitest/autorun"
require "authentication"
require "storage"
require "test_helper"

class AuthenticationTest < Minitest::Test
  def setup
    Storage.config.folder = "./tmp"
  end

  def test_get_access_token
    skip "To not reach a request limit"
    assert_equal(Authentication.get_access_token(&Storage::method(:set)).has_key?("access_token"), true)
  end

  def test_access_token_exception
    e = assert_raises(RuntimeError) do
      Authentication.get_access_token()
    end

    assert_equal(/callback/.match?(e.message), true)
  end

  def test_token_has_not_expired
    # Manipulate time
    t = Time.now + 3600

    assert_equal(Authentication.has_token_expired?({ "expires_at" => t.to_s }), false)
  end

  def test_token_has_expired
    # Manipulate time
    t = Time.now - 3600

    assert_equal(Authentication.has_token_expired?({ "expires_at" => t.to_s }), true)
  end

  def test_has_token_expired_exception
    e = assert_raises(RuntimeError) do
      Authentication.has_token_expired?
    end

    assert_equal(/expires/.match?(e.message), true)
  end
end
