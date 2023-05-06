FactoryBot.define do
    factory :terms_of_service_acceptance do
        user
        terms_of_service { true }
    end
  end