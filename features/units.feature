Feature: Track units spent
  In order to invoice the right amount
  As a freelancer
  I can track the units spent on a project

  Scenario: open units
    Given I am on the homepage
    When I go to the units page
    Then I am on the units page

  Scenario: add a unit
    Given I have a project
    When I add a unit
    Then the unit has been added

  Scenario: fail to add a unit
    When I try to add a unit with missing details
    Then the unit has not been added

  Scenario: list the units
    Given I have a unit
    When I list the units
    Then I see the list of units

  Scenario: edit a unit
    Given I have a unit
    When I update the unit
    Then the unit has been updated
