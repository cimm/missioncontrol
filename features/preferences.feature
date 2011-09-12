Feature: Set my personal preferences
  In order to allow the application to make smarter decissions
  As a freelancer
  I can manage my personal preferences

  Scenario: open preferences
    Given I am on the homepage
    When I go to the preferences page
    Then I am on the preferences page

  Scenario: list the preferences
    Given I have a preference
    When I list the preferences
    Then I see the list of preferences

  Scenario: update a preference
    Given I have a preference
    When I update the preference
    Then the preference has been updated
