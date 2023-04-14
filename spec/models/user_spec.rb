require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { FactoryBot.build(:user) }

    it { should validate_presence_of(:email) }

    it { should allow_value('keer@gmail.com').for(:email) }
    it { should_not allow_value('example.com').for(:email) }
  end

#   describe "associations" do
#     it { should have_many(:twitter_accounts) }
#   end

  describe "password" do
    it { should have_secure_password }
  end
end