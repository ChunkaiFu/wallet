Given("I am on the User Registration page") do
  visit new_user_registration_path
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I press {string}") do |button|
  click_on button
end

Then("I should be on the home page") do
  expect(current_path).to eq(root_path)
end

Then("I should be on the User Registration page") do
  expect(current_path).to eq(user_registration_path)
end

Then("I should see {string}") do |content|
  expect(page).to have_content content
end

