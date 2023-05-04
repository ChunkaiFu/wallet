require 'simplecov'
SimpleCov.start

Given(/the following users exist/) do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Given("I am on the User Registration page") do
  visit sign_up_path
end

Given("I am on the User Sign in page") do
  visit sign_in_path
end

Then("I should be on the User Sign in page") do
  expect(current_path).to eq(sign_in_path)
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
  expect(current_path).to eq(sign_up_path)
end

Then("I should see {string}") do |content|
  expect(page).to have_content content
end

When('I follow {string}') do |my_link|
  click_link(my_link)
end

And('I am on the home page') do
  visit root_path
end

