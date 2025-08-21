require "minitest/autorun"
require "shipment"

require "test_helper"

class ShipmentTest < Minitest::Test
  def test_post_shipment
    e = assert_raises(RuntimeError) do
      Shipment.post_shipment(file_fixture("shipment.json"))
    end

    assert_equal("ERROR Unauthorized", e.message)
  end
end
