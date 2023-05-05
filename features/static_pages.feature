Feature: Check static pages (Contact, Why Us, & Terms of Services)
  
Scenario: View "Contact" page
    Given I am on the home page
    When I follow "Contact"
    Then I should see "Contact Us"

Scenario: View "Why Us" page
    Given I am on the home page
    When I follow "Why Us"
    Then I should see "Our Mission"
    
Scenario: View "Terms of Services" page
    Given I am on the home page
    When I follow "Terms of Services"
    Then I should see "Terms of Service"
