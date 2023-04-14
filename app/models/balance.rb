class Balance < ApplicationRecord
  belongs_to :wallet
  validates :value, numericality: { greater_than: 0, less_than_or_equal_to: 9999.99, message: "must be between 0 and 9999.99" }
end
