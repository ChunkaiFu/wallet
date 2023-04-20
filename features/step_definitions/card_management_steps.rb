Given("I am logged in") do
    @user = User.create(email: "user@example.com", firstname: "User", lastname: "Example", password: "password127", password_confirmation: "password127")
    visit sign_in_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Sign In"
  end
  
  When("I click {string} in the navbar") do |page|
    click_on page
  end
  
  Then("I should be on the {string} page") do |page|
    expect(current_path).to eq(new_wallet_path)
    expect(page).to have_content(page)
  end
  
  And("I am on the MyCards page") do
    visit(wallet_cards_path)
  end
  
  When("I click the {string} button") do |button|
    click_on(button)
    puts current_path
  end
  
  And(/^I select "(.*?)" from the "(.*?)" dropdown$/) do |option_text, dropdown_id|
    select(option_text, from: dropdown_id)
  end
  
  
  And("I fill in the {string} field with {string}") do |field, value|
    fill_in field, with: value
  end
  
  And("I fill in the {string} field with {int}") do |field, value|
    fill_in field, with: value
  end
  
  Then("I should see the message {string}") do |message|
    expect(page).to have_content(message)
  end
  
  Then("I should see the new card on the cards page") do
    expect(page).to have_content("Chase")
    expect(page).to have_content("1111222233334444")
    expect(page).to have_content("12/25")
    expect(page).to have_content("Batman McGee")
  end
  
  And("does not have a wallet") do
    @user.cards.destroy_all 
  end
  
  When("the user clicks MyWallet in the navbar") do
    click_on "MyWallet"
  end
  
  Then("the user is redirected to the new card page") do
    expect(current_path).to eq(cards_path)
  end