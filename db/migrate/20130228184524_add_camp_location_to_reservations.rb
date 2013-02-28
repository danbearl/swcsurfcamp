class AddCampLocationToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :camp_location, :string
  end
end
