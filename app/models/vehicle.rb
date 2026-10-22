class Vehicle < ApplicationRecord
  has_many :drivers, dependent: :nullify
  has_many :maintenance_orders, dependent: :destroy
  has_many :fuelings, dependent: :destroy
  has_many :trips, dependent: :destroy

  enum :status, { active: 0, in_maintenance: 1, inactive: 2 }, validate: true, default: :active

  validates :plate, presence: true, uniqueness: true
  validates :model, :year, :kind, presence: true
  validates :odometer, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def label
    "#{model} (#{plate})"
  end
end
