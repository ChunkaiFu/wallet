class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}
end
