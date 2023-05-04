require 'simplecov'
SimpleCov.start

def sign_in(user)
  visit sign_in_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end

Given("I have created an account") do
  @user = User.create(email: "user@example.com", firstname: "User", lastname: "Example", password: "password127", password_confirmation: "password127")
end

And("I am kyc authenticated") do
  sign_in(@user)
  @kyc = Kyc.create(user: @user, license_number: "BIGF00T", status: "approved")
end

And("I have accepted the Terms of Services") do
  @user.update(terms_of_service: true)
end

And("I am signed in") do
    sign_in(@user)
end

Given("I am on the kyc page") do
    visit kyc_new_path
end