class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}
    validates :password, length: { minimum: 8 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/, message: "must be at least 8 characters and include at least one letter and one number" }

    def self.email_registered?(email)
        User.exists?(email: email)
    end
      
end
