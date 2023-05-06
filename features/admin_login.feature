Feature: Admin Login

Scenario: Admin Login
Given I am on the Admin Login page
  And I fill in "Email" with "admin@example.com"
  And I fill in "Password" with "password"
  And I press "Sign In"
  Then I should see "Dashboard"

Scenario: Invalid email
  Given I am on the Admin Login page
  And I fill in "Email" with "admin@xyz.com"
  And I fill in "Password" with "password"
  And I press "Sign In"
  Then I should see "Invalid email or password"