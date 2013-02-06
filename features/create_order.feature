Feature: Create a sandwich order
  To order a sandwich
  Users create a sandwich and submit the order

  @javascript
  Scenario: Create an order
    Given I have some seed data
    And I am logged in
    And I am directed to a welcome page
    When I create a new order
    Then I should see a page with various sandwich types
    And I select one as my template
    And I finalize my selection of ingredients
    And I submit my sandwich selection
    Then I should see a "veggie" sandwich in the list
    And I can then confirm my order
    And I am redirected to a thank you page with a snappy quote
    And I should generate an email of my order

  @javascript
  Scenario: Re-Order an historical order
    Given I have some seed data
    And I am logged in
    And I am on the Order History Page
    And I select a past order
    Then I should see a page with various sandwich types
    And I should see the sandwich ingredients pre-selected
    And I finalize my selection of ingredients
    And I submit my sandwich selection
    Then I should see a "turkey" sandwich in the list
    And I can then confirm my order
    And I am redirected to a thank you page with a snappy quote
    And I should generate an email of my order
