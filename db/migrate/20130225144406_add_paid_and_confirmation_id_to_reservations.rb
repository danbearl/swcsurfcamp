class AddPaidAndConfirmationIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :paid, :boolean
    add_column :reservations, :confirmation_id, :string
  end
end
