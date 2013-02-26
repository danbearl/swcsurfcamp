class Reservation < ActiveRecord::Base

  attr_accessible :address, :age, :camp_start_date, :date_signed, :email, :emergency_contact, :guardian_signature, :hold_harmless_signature, :insurance, :medical_provider, :name, :parental_consent_signature, :phone, :confirmation_id, :paid, :camp_type, :camp_price

  validates_presence_of :name, :age, :phone, :insurance, :parental_consent_signature, :hold_harmless_signature, :guardian_signature, :date_signed, :camp_start_date

  def payment_confirmed
    write_attribute :paid, true
    save!

  end

  def self.generate_random_id
    token = []
    options = Array('a'..'z') + Array(0..9) + Array(0..9) + Array('A'..'Z')

    15.times do
      token << options.sample
    end

    token = token.join('')

    return token

  end

end
