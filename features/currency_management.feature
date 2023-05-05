Feature: Add new currency to MyCash page

  Background:
    Given I have created an account
    And I am kyc authenticated
    And I have accepted the Terms of Services
    And I have a wallet with a card

  Scenario: Add USD currency with valid value and valid card (happy path)
    Given I am on the MyCash page
    When I click the "Add a new currency" button
    And I select "USD" from the "Currency" dropdown
    And I fill in "Value" with "100"
    And I select a valid card from the "Card" dropdown
    And I click the "Add" button
    Then I should see the message "Balance was successfully created."

  Scenario: Add EUR currency with invalid value and valid card (sad path)
    Given I have created an account
    And I am kyc authenticated
    And I have accepted the Terms of Services
    And I have a card in my wallet
    And I am on the MyCash page
    When I click the "Add a new currency" button
    And I select "EUR" from the "Currency" dropdown
    And I fill in "Value" with "invalid"
    And I select a valid card from the "Card" dropdown
    When I click the "Add" button
    Then I should see an error message


