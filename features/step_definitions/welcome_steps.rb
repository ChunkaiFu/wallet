Given(/^I am on the home page$/) do
    visit "/"
  end
  text = 'Virtual\nWallet'

  Then(/^I should see "(.*?)"$/) do |text|
    page.has_content?(text)
  end