Given("I am on the Admin Login page") do
    visit admin_login_path
end

Given("there are some users with KYCs in the system") do |table|
    table.hashes.each do |kyc_params|
      user = User.create!
      user.kycs.create!(kyc_params)
    end
  end

Given(/^I am on the admin dashboard$/) do
    visit admin_dashboard_path
  end
  Then(/^I should see the license number, status$/) do
    expect(page).to have_content "License Number"
    expect(page).to have_content "Status"
  end
  

  

  