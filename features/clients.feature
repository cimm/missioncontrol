Feature: Know my clients
  In order to know my clients
  As a freelancer
  I can track the work per client

  Scenario: add a client
    When I add a client
    Then the client has been added

  Scenario: list the clients
    Given I added a client
    When I list the clients
    Then I see the list of clients

  Scenario: update a client
    Given I added a client
    When I update the client
    Then the client has been updated
