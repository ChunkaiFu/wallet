Feature: Registration
  
  Scenario: register a user
  Given I am on the User Registration page
  And I fill in "Username" with "swetha123"
  And I fill in "Firstname" with "Swetha"
  And I fill in "Lastname" with "Reddy"
  And I fill in "Email" with "swetha@yahoo.com"
  And I fill in "Password" with "password"
  And I fill in "Password confirmation" with "password"
  And I press "Create my Account"
  Then I should be on the home page
  And I should see "Welcome! You have signed up successfully."
  
  Scenario: cannot register a user due to password(sad path)
  Given I am on the User Registration page
  And I fill in "Username" with "xyz"
  And I fill in "Firstname" with "xyz1"
  And I fill in "Lastname" with "wxy"
  And I fill in "Email" with "xyz@yahoo.com"
  And I fill in "Password" with "123"
  And I fill in "Password confirmation" with "123"
  And I press "Create my Account"
  Then I should be on the User Registration page
  And I should see "1 error prohibited this user from being saved:"
  And I should see "Password is too short (minimum is 6 characters)"
  
  