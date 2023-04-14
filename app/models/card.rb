class Card < ApplicationRecord
  belongs_to :wallet

  before_validation :convert_card_number_to_string
  before_validation :convert_date_to_string
  before_validation :convert_holder_name_to_string
  before_validation :convert_cvv_to_string

  validates :number, format: { with: /\A\d{16}\z/, message: "must be a 16-digit number" }
  validates :expiration_date, format: { with: /\A\d{2}\/\d{2}\z/, message: "must be in the format mm/yy" }
  validates :holder_name, format: { with: /\A[a-zA-Z]+\s[a-zA-Z]+\z/, message: "must be in the format of John Wick with a space between" }
  validates :cvv, length: { is: 3, message: "must be exactly 3 digits" }, numericality: { only_integer: true, message: "must only contain digits" }
  

  def convert_card_number_to_string
    self.number = number.to_s
  end

  def convert_holder_name_to_string
    self.holder_name = holder_name.to_s
  end

  def convert_date_to_string
    self.expiration_date = expiration_date.to_s
  end 

  def convert_cvv_to_string
    self.cvv = cvv.to_s 
  end 


end
