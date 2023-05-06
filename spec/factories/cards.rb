FactoryBot.define do
    factory :card do
      wallet
      number { "1234567812345678" }
      expiration_date { "12/22" }
      cvv { "123" }
      holder_name { "John Doe" }
    end
  end