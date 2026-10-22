class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :role, { admin: 0, operator: 1 }, validate: true, default: :operator

  validates :email_address, presence: true, uniqueness: true

  def admin?
    role == "admin"
  end
end
