Feature: Group per project
  In order to group my work per project
  As a freelancer
  I can track time on a project

  Scenario: open projects
    Given I am on the homepage
    When I go to the projects page
    Then I am on the projects page

  Scenario: add a project
    Given I have a client
    When I add a project
    Then the project has been added

  Scenario: list the projects
    Given I have a project
    When I list the projects
    Then I see the list of projects

  Scenario: edit a project
    Given I have a project
    When I update the project
    Then the project has been updated
