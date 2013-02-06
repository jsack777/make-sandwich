Feature: Create a sandwich order
  To order a sandwich
  Users create a sandwich and submit the order

  Background:
    Given I have some seed data
    And I am logged in

  @javascript
  Scenario: Create an order
    And I am directed to a welcome page
    And I create a new order
    And I should see a page with various sandwich types
    And I choose a veggie theme
    When I submit my selection
    Then I should see a "veggie" sandwich in the list
    And I finish my order

  @javascript
  Scenario: Re-Order an historical order
    And I am on the Order History Page
    And I select a past order
    And I should see a page with various sandwich types
    When I submit my selection
    Then I should see a "turkey" sandwich in the list
    And I finish my order
