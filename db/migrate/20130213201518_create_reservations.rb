class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name
      t.integer :age
      t.string :phone
      t.text :address
      t.string :email
      t.string :emergency_contact
      t.boolean :insurance
      t.string :medical_provider
      t.string :parental_consent_signature
      t.string :hold_harmless_signature
      t.string :guardian_signature
      t.date :date_signed
      t.date :camp_start_date

      t.timestamps
    end
  end
end
