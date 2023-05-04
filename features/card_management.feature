Feature: Card Management
  
  In order to enable the use of MyCash
  As a user
  I want to add a card to my account
  
    
  Scenario: User creates wallet
    Given I have created an account
    And I am kyc authenticated
    And I have accepted the Terms of Services
    When I click "MyCards" in the navbar
    And I click the "Add some cards" button
    Then I should see the message "Successfully created wallet!"

  Scenario: User adds first card to their wallet
    Given I have created an account
    And I am kyc authenticated
    And I have accepted the Terms of Services
    And I have a wallet
    And I am on the MyCards page
    When I click the "Add a card now!" button
    And I fill in the "Card number" field with "1111222233334444"
    And I fill in the "Expiration date" field with "12/25"
    And I fill in the "Card holder name" field with "Batman McGee"
    And I fill in the "Cvv" field with "456"
    And I select "DISCOVER" from the "Issuer" dropdown
    And I click the "Add Card" button
    Then I should see the message "Card was successfully created"
    And I should see the new card on the cards page
    
  Scenario: User deletes a card
    Given I have created an account
    And I am kyc authenticated
    And I have accepted the Terms of Services
    And I have a card in my wallet
    And I am on the MyCards page
    When I click the "Delete" button
    Then I should see the message "Card was successfully destroyed"