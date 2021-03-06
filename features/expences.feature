Feature: Track my expenses
  I order to know what I really earn
  As a freelancer
  I can track what I spent

  Scenario: open expenses
    Given I am on the homepage
    When I go to the expenses page
    Then I am on the expenses page

  Scenario: add an expense
    When I add an expense
    Then the expense has been added

  Scenario: list the expenses
    Given I have an expense
    When I list the expenses
    Then I see the list of expenses

  Scenario: filter the expenses per fiscal quarter
    Given I have expenses in every quarter
    When I filter by one quarter
    Then I only see the expenses in that quarter

  Scenario: update an expense
    Given I have an expense
    When I update the expense
    Then the expense has been updated
