require "test_helper"

class TripTest < ActiveSupport::TestCase
  test "driver with expired CNH cannot be allocated to a trip" do
    vehicle = vehicles(:one)
    driver = Driver.new(name: "Maria Santos", cnh: "99900011122", cnh_expiration: Date.current - 1.day)

    trip = Trip.new(vehicle: vehicle, driver: driver, started_at: Time.current)

    assert_not trip.valid?
    assert_includes trip.errors[:driver].join, "CNH vencida"
  end

  test "vehicle cannot have two overlapping trips" do
    vehicle = vehicles(:one)
    driver = drivers(:one)
    started_at = Time.current - 5.days
    ended_at = Time.current - 4.days

    Trip.create!(vehicle: vehicle, driver: driver, started_at: started_at, ended_at: ended_at)
    overlapping = Trip.new(vehicle: vehicle, driver: driver, started_at: started_at + 12.hours, ended_at: ended_at + 12.hours)

    assert_not overlapping.valid?
    assert_includes overlapping.errors[:vehicle].join, "já está em uma viagem"
  end

  test "vehicle can have sequential non-overlapping trips" do
    vehicle = vehicles(:two)
    driver = drivers(:two)

    Trip.create!(vehicle: vehicle, driver: driver, started_at: Time.current - 10.days, ended_at: Time.current - 8.days)
    sequential = Trip.new(vehicle: vehicle, driver: driver, started_at: Time.current - 7.days, ended_at: Time.current - 6.days)

    assert sequential.valid?
  end
end
