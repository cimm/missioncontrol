Feature: Know my clients
  In order to know my clients
  As a freelancer
  I can track the work per client

  Scenario: add a client
    When I add a client
    Then the client has been added

  Scenario: list the client's nicknames
    Given I added a client
    When I list the clients
    Then I see the nickname of the client

  Scenario: edit a client
    Given I added a client
    When I edit the client's nickname
    Then I see the client's new nickname
