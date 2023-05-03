FactoryBot.define do
    factory :kyc do
      user
      status { "pending" }
      license_number { "12345678" }
      # add any other attributes that your KYC model requires
    end
  end
  
  