class Reservation < ActiveRecord::Base
  attr_accessible :address, :age, :camp_start_date, :date_signed, :email, :emergency_contact, :guardian_signature, :hold_harmless_signature, :insurance, :medical_provider, :name, :parental_consent_signature, :phone

  validates_presence_of :name, :age, :phone, :insurance, :parental_consent_signature, :hold_harmless_signature, :guardian_signature, :date_signed, :camp_start_date
end
