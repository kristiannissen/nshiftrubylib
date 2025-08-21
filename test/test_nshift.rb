require "minitest/autorun"
require "nshift"
require "authentication"
require "shipment"

require "test_helper"

class NshiftTest < Minitest::Test
  def test_say_hello
    assert_equal(Nshift.say_hello, "Hello Kitty")
  end
end
