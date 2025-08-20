require "minitest/autorun"
require "storage"

class StorageTest < Minitest::Test

  def test_set
    assert_equal(Storage.set("kitty", {hello: "Kitty"}), true)
  end

  def test_get
    assert_equal(Storage.get("kitty")["hello"], "Kitty")
  end
end
