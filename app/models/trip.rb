class Trip < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver

  validates :started_at, presence: true
  validates :distance_km, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validate :driver_must_have_valid_cnh
  validate :vehicle_must_not_have_overlapping_trip

  def ongoing?
    ended_at.blank?
  end

  private

  def driver_must_have_valid_cnh
    return if driver.nil? || driver.cnh_expiration.nil?
    errors.add(:driver, "com CNH vencida não pode ser alocado a uma viagem") if driver.cnh_expiration < Date.current
  end

  def vehicle_must_not_have_overlapping_trip
    return if vehicle_id.blank? || started_at.blank?
    new_end = ended_at.presence || (started_at + 1.year)
    overlap = Trip.where(vehicle_id: vehicle_id)
                  .where.not(id: id)
                  .where("started_at < ?", new_end)
                  .where("ended_at IS NULL OR ended_at > ?", started_at)
    errors.add(:vehicle, "já está em uma viagem nesse período") if overlap.exists?
  end
end
