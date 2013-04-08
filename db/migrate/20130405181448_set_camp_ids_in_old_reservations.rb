class SetCampIdsInOldReservations < ActiveRecord::Migration
  def up
    Reservation.all.each do |reservation|
      camp = Camp.where("start_date = ?", reservation.camp_start_date).first
      reservation.update_attribute(:camp_id, camp.id)
    end
  end

  def down
    Reservation.all.each do |reservation|
      camp = Camp.find(reservation.camp_id).first
      
      reservation.update_attributes(
        camp_start_date: camp.start_date,
        camp_price: camp.price,
        camp_location: camp.location,
        camp_type: camp.camp_type
      )
    end
  end
end
