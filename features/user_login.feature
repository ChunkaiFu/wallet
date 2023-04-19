Feature: Login
  
  Background:
  Given the following users exist:
  | email            | password    | password_confirmation  | firstname | lastname | 
  | john1@gmail.com  | secret123   | secret123              | john      | doe      |
  | sarah2@mail.com  | password123 | password123            | sarah     | dee      | 
 
  Scenario: sign in a user
  Given I am on the User Sign in page
  And I fill in "Email" with "john1@gmail.com"
  And I fill in "Password" with "secret123"
  And I press "Sign In"
  Then I should be on the home page
  And I should see "Logged in successfully!"
  
  Scenario: sign out a user
  Given I am on the User Sign in page
  And I fill in "Email" with "john1@gmail.com"
  And I fill in "Password" with "secret123"
  And I press "Sign In"
  Then I should be on the home page
  And I press "Log out"
  Then I should see "Logged out"
  
  Scenario: invalid email
  Given I am on the User Sign in page
  And I fill in "Email" with "john123@gmail.com"
  And I fill in "Password" with "secret123"
  And I press "Sign In"
  Then I should be on the User Sign in page
  And I should see "Invalid email or password!"
  
  Scenario: user not signed in
  Given I am on the User Sign in page
  And I follow "MyCash"
  Then I should be on the User Sign in page
  And I should see "You must sign in to do that."
  
