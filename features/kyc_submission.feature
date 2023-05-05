Feature: KYC Submission
  
  Background:   
    Given I have created an account
    And I have accepted the Terms of Services
    And I am signed in
  
  Scenario: User submits new kyc information
    Given I am on the kyc page
    When I fill in "License number" with "BIGF00T"
    And I press "Submit"
    Then I should see "KYC status: awaiting"
    
    