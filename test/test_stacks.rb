require "minitest/autorun"
require "stacks"

class StacksTest < Minitest::Test

  def test_get_stack
    skip "Updated access token is needed"
    assert_equal(Stacks.get_stacks, true)
  end
end
