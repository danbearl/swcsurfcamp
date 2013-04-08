class SetBalanceOnExistingReservations < ActiveRecord::Migration
  def up
    Reservation.all.each do |reservation|
      camp = Camp.find(reservation.camp_id)
      reservation.update_attribute(:balance, camp.price)
    end
  end

  def down
    Reservation.all.each do |reservation|
      resrvation.update_attribute(:balance, nil)
    end
  end
end
