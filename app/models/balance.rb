class Balance < ApplicationRecord
  belongs_to :wallet
  validates :value, numericality: { greater_than: 0, less_than_or_equal_to: 9999.99, message: "must be between 0 and 9999.99" }
  before_create :ensure_wallet_has_card

  private 

  def ensure_wallet_has_card
    unless wallet.cards.any?
      errors.add(:base, "You must link at least one card to your account before creating a new balance")
      throw(:abort)
    end
  end

end
