require "minitest/autorun"
require "dotenv/load"
require "stacks"

class StacksTest < Minitest::Test
  def setup
    Storage.config.folder = "./tmp"
  end
end
