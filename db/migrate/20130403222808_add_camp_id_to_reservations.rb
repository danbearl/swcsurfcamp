class AddCampIdToReservations < ActiveRecord::Migration
  def change
    change_table :reservations do |t|
      t.integer :camp_id
    end
  end
end
