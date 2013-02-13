class ReservationsController < ApplicationController

  expose(:reservations)
  expose(:reservation)
  expose(:reservation, model: Reservation)

  def create
    if reservation.save
      redirect_to new_reservation, notice: "Reservation successful."
    else
      render 'new'
    end
  end

  def update
    if reservation.save
      redirect_to reservation, "Reservation updated."
    else
      render 'edit'
    end
  end

  def destroy
    reservation.destroy
    redirect_to :root, message: "Reservation was deleted."
  end
end
