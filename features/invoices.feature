Feature: Get payed for my work
  I order to get payed for my work
  As a freelancer
  I can create invoices based on my work

  Scenario: open invoices
    Given I am on the homepage
    When I go to the invoices page
    Then I am on the invoices page

  Scenario: add an invoice
    When I add an invoice
    Then the invoice has been added

  Scenario: fail to add an invoice
    When I try to add an invoice with missing details
    Then the invoice has not been added

  Scenario: list the invoices
    Given I have a payed invoice
    When I list the invoices
    Then I see the list of invoices

  Scenario: see which invoices are overdue
    Given I have an overdue invoice
    When I list the invoices
    Then I see the invoice is overdue

  Scenario: update an invoice
    Given I have an invoice
    And I have a unit
    When I update the invoice
    Then the invoice has been updated
