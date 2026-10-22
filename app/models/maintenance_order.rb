class MaintenanceOrder < ApplicationRecord
  belongs_to :vehicle

  enum :kind, { preventive: 0, corrective: 1 }, validate: true
  enum :status, { open: 0, scheduled: 1, completed: 2 }, validate: true, default: :open

  validates :opened_at, presence: true
  validates :odometer, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  def in_progress?
    released_at.blank?
  end
end
