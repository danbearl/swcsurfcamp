Feature: Reservation
  Scenario: Create New Reservation
    Given I am on the new reservation page.
    When I fill in the following:
      | reservation_name | Dianne |
      | reservation_age | 14 |
      | reservation_phone | 123-456-7890 |
      | reservation_medical_provider | doctor who |
      | reservation_parental_consent_signature | Janice |
      | reservation_hold_harmless_signature | Janice |
      | reservation_guardian_signature | Janice |
      | reservation_date_signed | 01/01/2013 |
      | reservation_camp_start_date | 05/01/2013 |
    And choose yes to insurance
    And I press "Create Reservation"
    Then I should see "Reservation successful."
    And I should see "Payment Options"
