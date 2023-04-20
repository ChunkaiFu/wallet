class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}, uniqueness: { message: "has already been registered" }
    has_secure_password
    has_one :wallet

    before_validation :convert_email_to_string
    before_validation :convert_password_to_string
    before_validation :convert_password_confirmation_to_string

    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}
    validates :password, length: { minimum: 8 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/, message: "must be at least 8 characters and include at least one letter and one number" }

    def self.email_registered?(email)
        User.exists?(email: email)
    end
      
    def convert_email_to_string 
        self.email = email.to_s
    end 

    def convert_password_to_string 
        self.password = password.to_s 
    end 

    def convert_password_confirmation_to_string
        self.password_confirmation = password_confirmation.to_s
    end 

end

