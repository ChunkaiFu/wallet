class Kyc < ApplicationRecord
  belongs_to :user

  enum status: [:pending, :approved, :rejected, :awaiting]
  attribute :status, :string, default: "pending"
  validates :license_number, uniqueness: { scope: :user_id, message: "has already been taken" }
end
