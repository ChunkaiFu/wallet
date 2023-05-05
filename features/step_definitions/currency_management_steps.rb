require 'simplecov'
SimpleCov.start

And("I have a wallet with a card") do
  @user.wallet ||= Wallet.create
  @card = @user.wallet.cards.create(number: "2222333344445555", expiration_date: "12/34", holder_name: "Megaman McGee", cvv: "999", issuer: "VISA")
end

Given("I am on the MyCash page") do
    visit wallet_balances_path
end

Then("I should see a {string} dropdown") do |dropdown_label|
  expect(page).to have_select(dropdown_label)
end

Then("I should see a {string} text box") do |textbox_label|
  expect(page).to have_field(textbox_label)
end

When("I select a valid card from the {string} dropdown") do |dropdown_label|
  select("VISA - 5555", from: dropdown_label)
end

Then("I should see an error message") do
  expect(page).to have_content("Value must be between 0 and 9999.99")
end
