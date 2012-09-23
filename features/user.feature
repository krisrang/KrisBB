Feature: User management
  In order to have a account
  As a visitor
  I should be able to manage my account

  Scenario: Visitor registers
    Given I am logged out
    When I sign up
    Then I should be logged in

  Scenario: Visitor fails registering
    Given I am logged out
    When I fail to sign up
    Then I should see an error on "Username"

  Scenario: User logs in
    Given I am registered
    When I log in
    Then I should be logged in

  Scenario: User fails logging in
    Given I am registered
    When I fail to log in
    Then I should see "Sign In"

  Scenario: User lists users
    Given I am logged in
    When I visit user list
    Then I should see a list of users

  Scenario: User visits profile
    Given I am logged in
    When I visit my profile page
    Then I should see my profile

  Scenario: User changes email
    Given I am logged in
    When I change my "email"
    Then My "email" should be changed

  Scenario: User changes password
    Given I am logged in
    When I change my "password"
    Then My "password" should be changed

  Scenario: User uploads avatar
    Given I am logged in
    When I upload a new avatar
    Then My "avatar" should be changed

  Scenario: User uploads invalid avatar
    Given I am logged in
    When I upload an invalid avatar
    Then I should see an error on "Set avatar"

  Scenario: User logs out
    Given I am logged in
    When I log out
    Then I should be logged out

  Scenario: Admin edits another user
    Given I am logged in as admin
    When I edit another user
    Then I should be able to update the user

  Scenario: Admin deletes user
    Given I am logged in as admin
    When I delete another user
    Then I should not see the user

  Scenario: User tries to edit another user
    Given I am logged in
    When I edit another user
    Then I should see authorization error
