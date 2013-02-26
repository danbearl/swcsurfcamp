class RenameTypeInReservations < ActiveRecord::Migration

  def change
    change_table :reservations do |t|
      t.string :camp_type
      t.float :camp_price
    end
  end
end
