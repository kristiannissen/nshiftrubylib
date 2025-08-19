require "minitest/autorun"
require "nshift"
require "authentication"
require "shipment"

require "test_helper"

class NshiftTest < Minitest::Test

  def test_say_hello
    assert_equal(Nshift.say_hello, "Hello Kitty")
  end

  def test_get_access_token
    # assert_equal(Authentication.get_access_token.has_key?("access_token"), true)
  end

  def test_shipment_post_shipment
    assert_equal(file_fixture("shipment.json").has_key?("InstallationID"), true)
  end
end
