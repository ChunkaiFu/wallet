FactoryBot.define do
    factory :wallet do
      user { association(:user) }
      # any other necessary attributes
    end
  end
  