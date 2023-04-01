Feature: Login
  
  Background:
  Given the following users exist:
  | email           | password |
  | john@gmail.com  | secret   |
  | sarah@mail.com  | password |

  Scenario: sign in a user
  Given I am on the User Sign in page
  And I fill in "Email" with "john@gmail.com"
  And I fill in "Password" with "secret"
  And I press "Sign In"
  Then I should be on the home page
  And I should see "Logged in successfully!"
  
  Scenario: sign out a user
  Given I am on the User Sign in page
  And I fill in "Email" with "john@gmail.com"
  And I fill in "Password" with "secret"
  And I press "Sign In"
  Then I should be on the home page
  And I press "Log out"
  Then I should see "Logged out"
  
  Scenario: invalid email
  Given I am on the User Sign in page
  And I fill in "Email" with "john123@gmail.com"
  And I fill in "Password" with "secret"
  And I press "Sign In"
  Then I should be on the User Sign in page
  And I should see "Invalid email or password!"
  
  Scenario: user not signed in
  Given I am on the User Sign in page
  And I follow "MyWallet"
  Then I should be on the User Sign in page
  And I should see "You must sign in to do that."
  
