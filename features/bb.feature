Feature: BB main app
  In order to communicate with other users
  As a user
  I should be able to see and leave messages

  @javascript
  Scenario: BB has messages
    Given I am logged in
      And There are 3 messages
    When I go to the home page
    Then I should see recent messages
      And I should see messagebox

  @javascript
  Scenario: BB has no messages
    Given I am logged in
      And There are no messages
    When I go to the home page
    Then I should see messages placeholder
