require 'simplecov'
SimpleCov.start

And("another user exists") do
  @another_user = User.create(email: "another_user@example.com", firstname: "Another", lastname: "User", password: "password128", password_confirmation: "password128", terms_of_service: true)
end

And('I have a balance of USD currency') do
  @balance = @user.wallet.balances.create(currency: "USD", value: 9000.0)
  # @balance = @user.wallet.balances.find_by(currency: "USD")
  expect(@balance.value).to eq(9000.0)
  expect(@balance.currency).to eq("USD")
end

And("the user is kyc authenticated") do
  @another_kyc = Kyc.create(user: @another_user, license_number: "BIGT0ES", status: "approved")
  @another_user.update(terms_of_service: true)
end

And("the user accepted the Terms of Services") do
    @another_user.update(terms_of_service: true)
end

And("the user has a wallet with a card") do
  @another_user.wallet ||= Wallet.create
  @another_card = @another_user.wallet.cards.create(number: "2222333344441111", expiration_date: "12/33", holder_name: "Doofus McLugnuts", cvv: "888", issuer: "DISCOVER")
end

And("the user has a balance of USD currency") do
  @another_balance = @another_user.wallet.balances.create(wallet: @another_user.wallet, currency: "USD", value: 10)
end

