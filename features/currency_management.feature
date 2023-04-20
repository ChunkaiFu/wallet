Feature: Add new currency to MyCash page

  Background:
    Given I am logged in
    And I have a wallet with a card

  Scenario: Add a new currency
    Given I am on the MyCash page
    And I click the "Add a new currency" button
    Then I should see a "Currency" dropdown
    And I should see a "Value" text box
    And I should see a "Card" dropdown

  Scenario: Add USD currency with valid value and valid card
    Given I am on the MyCash page
    And I click the "Add a new currency" button
    And I select "USD" from the "Currency" dropdown
    And I fill in "Value" with "100"
    And I select a valid card from the "Card" dropdown
    When I click the "Add" button
    Then I should see the message "Balance was successfully created."

  Scenario: Add EUR currency with invalid value and valid card
    Given I am on the MyCash page
    And I click the "Add a new currency" button
    And I select "EUR" from the "Currency" dropdown
    And I fill in "Value" with "invalid"
    And I select a valid card from the "Card" dropdown
    When I click the "Add" button
    Then I should see an error message


