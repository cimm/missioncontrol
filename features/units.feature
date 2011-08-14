Feature: Track units spent
  In order to invoice the right amount
  As a freelancer
  I can track the units spent on a project

  Scenario: add a unit
    When I add a unit
    Then the unit has been added

  Scenario: show a unit's track date
    Given I added a unit
    When I list the units
    Then I see date the unit was executed
