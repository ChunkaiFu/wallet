Feature: Admin KYC status

In order to enable user to be transact
As an Admin
I want to update the KYC status

Scenario: Viewing a KYC record
Given I am on the Admin Login page
And I fill in "Email" with "admin@example.com"
And I fill in "Password" with "password"
And I press "Sign In"
Then I should see "Dashboard"
And I follow "Kycs"
Then I should see "Kycs"