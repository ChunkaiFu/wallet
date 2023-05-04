Feature: Transactions
  
Background:
    Given I have created an account
    And I am kyc authenticated
    And I have accepted the Terms of Services
    And I have a wallet with a card
    And I have a balance of USD currency
    And I am signed in
    Given another user exists
    And the user is kyc authenticated
    And the user accepted the Terms of Services
    And the user has a wallet with a card
    And the user has a balance of USD currency
    
Scenario: Send another user some money
    Given I follow "Transactions"
    When I click the "New Transaction!" button
    And I fill in "Email" with "another_user@example.com"
    And I fill in "Amount" with "300.0"
    And I click the "Initiate transaction" button
    Then I should see "Transaction created!"