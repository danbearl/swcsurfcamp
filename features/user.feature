Feature: User
  Scenario: User Logs In
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And I am on the login page
    When I fill in the following:
      | email    | dan@example.com |
      | password | pass            |
    And I press "Log In"
    Then I should see "Logged in successfully."
    And I should see "Welcome to the home of"
    And I should not see "Admin Log In"

  Scenario: User Logs Out
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And I am on the home page
    When I follow "Log Out"
    Then I should see "Logged out successfully."
    And I should not see "Log Out"
