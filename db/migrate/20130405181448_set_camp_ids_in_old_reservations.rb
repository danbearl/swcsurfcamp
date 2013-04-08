class SetCampIdsInOldReservations < ActiveRecord::Migration
  def up
    Reservation.all.each do |reservation|
      camp = Camp.where("start_date = ?", reservation.camp_start_date).first
      reservation.update_attribute(:camp_id, camp.id)
    end
  end

  def down
    Reservation.all.each do |reservation|
      resrvation.update_attribute(:camp_id, nil)
    end
  end
end
