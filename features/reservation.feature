Feature: Reservation
  Scenario: Create New Reservation
    Given I am on the new reservation page.
    When I fill in the following:
      | reservation_name                       | Dianne       |
      | reservation_age                        | 14           |
      | reservation_phone                      | 123-456-7890 |
      | reservation_medical_provider           | doctor who   |
      | reservation_parental_consent_signature | Janice       |
      | reservation_hold_harmless_signature    | Janice       |
      | reservation_guardian_signature         | Janice       |
    And I select the following:
      | reservation_date_signed_1i     | 2013    |
      | reservation_date_signed_2i     | January |
      | reservation_date_signed_3i     | 1       |
      | reservation_camp_start_date_1i | 2013    |
      | reservation_camp_start_date_2i | May     |
      | reservation_camp_start_date_3i | 1       |
    And I choose yes to insurance
    And I press "Create Reservation"
    Then I should see "Reservation successful."
    And I should see "Payment Options"
