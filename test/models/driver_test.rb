require "test_helper"

class DriverTest < ActiveSupport::TestCase
  test "cnh_expired? is true when expiration is in the past" do
    driver = Driver.new(name: "João", cnh: "11122233344", cnh_expiration: Date.current - 1.day)
    assert driver.cnh_expired?
  end

  test "cnh_expired? is false when expiration is in the future" do
    driver = Driver.new(name: "Ana", cnh: "55566677788", cnh_expiration: Date.current + 1.year)
    assert_not driver.cnh_expired?
  end
end
