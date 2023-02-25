Feature: Registration 
Background: 
Given user on the homepage  
And user follows "Register"  
@regression  
Scenario: Create a New User 
When user fills "Username textbox" with "p123"
When user fills "email textbox" with "pkeerthana@gmail.com"  
And user clicks "create an account button"  
And user enters the following details 
| First Name | Polkampally| 
| Last Name | Keerthana| 
| Password | 123456 | 
And user clicks "create my account button"