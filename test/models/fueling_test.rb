require "test_helper"

class FuelingTest < ActiveSupport::TestCase
  test "consumption_km_l is calculated from previous fueling" do
    fuelings = vehicles(:one).fuelings.order(:date, :id)
    last = fuelings.last

    # 9500 -> 10000 km = 500 km com 38.5 L
    assert_in_delta 500.0 / 38.5, last.consumption_km_l, 0.01
  end
end
