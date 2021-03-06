Feature: Know my clients
  In order to know my clients
  As a freelancer
  I can track the work per client

  Scenario: open clients
    Given I am on the homepage
    When I go to the clients page
    Then I am on the clients page

  Scenario: add a client
    When I add a client
    Then the client has been added

  Scenario: add an empty client
    When I try to add an empty client
    Then the client has not been added

  Scenario: list the clients
    Given I have a client
    When I list the clients
    Then I see the list of clients

  Scenario: update a client
    Given I have a client
    When I update the client
    Then the client has been updated

  Scenario: validate VAT number
    Given I have a client with a VAT number
    When I edit the client
    Then the VAT number is validated
