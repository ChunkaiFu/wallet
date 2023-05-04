Feature: Registration
  
  Scenario: register a user
  Given I am on the User Registration page
  When I fill in "Email" with "swetha@yahoo.com"
  And I fill in "Firstname" with "Swetha"
  And I fill in "Lastname" with "Reddy"
  And I fill in "Password" with "password789"
  And I fill in "Password confirmation" with "password789"
  And I press "Sign up"
  Then I should see "Successfully created account!"

  Scenario: cannot register a user due to email (sad path)
  Given I am on the User Registration page
  And I fill in "Email" with "xyz.com"
  And I fill in "Firstname" with "Stephen"
  And I fill in "Lastname" with "A Smith"
  And I fill in "Password" with "password123"
  And I fill in "Password confirmation" with "password123"
  And I press "Sign up"
  Then I should be on the User Registration page
  And I should see "Email must be a valid email address"
  
 Scenario: cannot register a user due to password (sad path)
  Given I am on the User Registration page
  And I fill in "Email" with "xyz@yahoo.com"
  And I fill in "Firstname" with "Ray"
  And I fill in "Lastname" with "Charles"
  And I fill in "Password" with "password"
  And I fill in "Password confirmation" with "password"
  And I press "Sign up"
  Then I should be on the User Registration page
