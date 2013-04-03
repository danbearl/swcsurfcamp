class AddBalanceToReservations < ActiveRecord::Migration
  def change
    change_table :reservations do |t|
      t.float :balance
    end
  end
end
