Feature: Card Management
  
  In order to enable the use of MyCash
  As a user
  I want to add a card to my account
  

  Scenario: User logs in and navigates to MyCards page
    Given I am logged in 
    When I click "MyCards" in the navbar
    Then I should be on the "MyCards" page
    

  Scenario: User adds first card to their wallet (happy path)
    Given I am logged in
    And I am on the MyCards page
    When I click the "Add some cards" button
    And I click the "Add a card now!" button
    And I fill in the "Card number" field with "1111222233334444"
    And I fill in the "Expiration date" field with "12/25"
    And I fill in the "Card holder name" field with "Batman McGee"
    And I fill in the "Cvv" field with "456"
    And I select "DISCOVER" from the "Issuer" dropdown
    And I click the "Add Card" button
    Then I should see the message "Card was successfully created"
    And I should see the new card on the cards page
    
    
 