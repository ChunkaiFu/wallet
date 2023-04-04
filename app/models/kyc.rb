class Kyc < ApplicationRecord
  belongs_to :user
  before_validation :set_default_status

  enum status: [:pending, :approved, :rejected, :awaiting]
  validates :status, inclusion: { in: statuses.keys }
  private
  def set_default_status
    self.status ||= "pending"
  end
end
