class Wallet < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  has_many :balances, dependent: :destroy 

end

