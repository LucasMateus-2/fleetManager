class Driver < ApplicationRecord
  belongs_to :vehicle, optional: true
  has_many :trips, dependent: :destroy

  validates :name, :cnh, :cnh_expiration, presence: true
  validates :cnh, uniqueness: true

  def cnh_expired?
    cnh_expiration.present? && cnh_expiration < Date.current
  end
end
