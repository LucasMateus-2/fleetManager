class Fueling < ApplicationRecord
  belongs_to :vehicle

  validates :date, :liters, :cost, :odometer, presence: true
  validates :liters, numericality: { greater_than: 0 }
  validates :cost, numericality: { greater_than_or_equal_to: 0 }
  validates :odometer, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def previous
    vehicle.fuelings
           .where("date < ? OR (date = ? AND id < ?)", date, date, id)
           .order(:date, :id)
           .last
  end

  def consumption_km_l
    prev = previous
    return nil if prev.nil?
    distance = odometer - prev.odometer
    return nil if distance <= 0 || liters.to_f <= 0
    (distance.to_f / liters.to_f).round(2)
  end

  def cost_per_km
    prev = previous
    return nil if prev.nil?
    distance = odometer - prev.odometer
    return nil if distance <= 0
    (cost.to_f / distance.to_f).round(3)
  end
end
