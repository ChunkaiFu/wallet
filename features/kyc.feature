Feature: KYC
  
  Background:
  Given the following users exist:
  | email           | password |
  | john@gmail.com  | secret   |
  
  Scenario: Submit KYC
    Given I am on the User Sign in page
    And I fill in "Email" with "john@gmail.com"
    And I fill in "Password" with "secret"
    And I press "Sign In"
    Then I should be on the home page
    And I should see "Logged in successfully!"
    And I follow "KYC"
    Then I should be on the KYC page
    And I fill in "License number" with "ABCD"
    And I press "Submit"
    Then I should see "KYC Status"
  