require "minitest/autorun"
require "nshift"
require "authentication"

class NshiftTest < Minitest::Test

  def test_say_hello
    assert_equal(Nshift.say_hello, "Hello Kitty")
  end

  def test_get_access_token
    assert_equal(Authentication.get_access_token.has_key?("access_token"), true)
  end
end
