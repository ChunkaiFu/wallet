Feature: Login

  Background:
    Given I have created an account
    And I am kyc authenticated
    And I have accepted the Terms of Services

  Scenario: sign in
  Given I am on the User Sign in page
  And I fill in "Email" with "user@example.com"
  And I fill in "Password" with "password127"
  And I press "Sign In"
  Then I should see "Logged in successfully!"
  
  Scenario: sign out
  Given I am signed in
  And I am on the home page
  When I press "Log out"
  Then I should see "Logged out"
  
  Scenario: invalid email
  Given I am on the User Sign in page
  And I fill in "Email" with "john"
  And I fill in "Password" with "secret1234"
  And I press "Sign In"
  Then I should be on the User Sign in page
  And I should see "Invalid email or password!"
  
  Scenario: user tries to access wallet while not signed in
  Given I am on the User Sign in page
  When I press "Log out"
  And I follow "MyCards"
  Then I should be on the User Sign in page
  And I should see "You must sign in to do that."
  
