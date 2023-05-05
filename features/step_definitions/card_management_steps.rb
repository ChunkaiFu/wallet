require 'simplecov'
SimpleCov.start

When("I click {string} in the navbar") do |page|
  click_on page
  expect(current_path).to eq(new_wallet_path)
end

Then("I should be on the {string} page") do |page|
  expect(current_path).to eq(new_wallet_path)
  expect(page).to have_content(page)
end

Given("I have a wallet") do
  @user.wallet = Wallet.create
end

And("I am on the MyCards page") do
  visit(wallet_cards_path)
end

When("I click the {string} button") do |button|
  click_on(button)
end

And(/^I select "(.*?)" from the "(.*?)" dropdown$/) do |option_text, dropdown_id|
  select(option_text, from: dropdown_id)
end

And("I fill in the {string} field with {string}") do |field, value|
  field_id = case field
             when "Card number"
               "card_number"
             when "Expiration date"
               "card_expiration_date"
             when "Card holder name"
               "card_holder_name"
             when "Cvv"
               "card_cvv"
             end
  find_field(field_id).set(value)
end

Then("I should see the message {string}") do |message|
  expect(page).to have_content(message)
end

Then("I should see the new card on the cards page") do
  expect(page).to have_content("DISCOVER")
  expect(page).to have_content("12/25")
  expect(page).to have_content("Batman McGee")
end

And("does not have a wallet") do
  @user.cards.destroy_all
end

Then("the user is redirected to the new card page") do
  expect(current_path).to eq(cards_path)
end

And("I have a card in my wallet") do
  @user.wallet ||= Wallet.create
  @card = @user.wallet.cards.create(number: "2222333344445555", expiration_date: "12/34", holder_name: "Megaman McGee", cvv: "999")
end
