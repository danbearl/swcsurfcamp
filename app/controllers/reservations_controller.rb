class ReservationsController < ApplicationController
  before_filter :require_user, except: [:new, :create, :show, :search]

  expose(:reservations)
  expose(:reservation)
  expose(:unique_id) do |id|
    begin
      token = Reservation.generate_random_id

    end while Reservation.where(confirmation_id: token) != []
    id = token
  end

  expose(:search_results) { Reservation.where(confirmation_id: params['query']) }

  expose(:open_camps) do
    available = []
    Camp.all.each do |camp|
      if camp.reservations.size < 30
        available << camp
      end
    end

    available
  end

  expose(:camp_options) do
    options = []
    open_camps.each do |camp|
      if camp.start_date > Date.today
        options << [camp.start_date.to_formatted_s(:long), camp.id]
      end
    end

    options
  end

  expose(:selected_camp) { Camp.find(params['selected_camp'])}

  def create
    reservation.camp_id = selected_camp.id
    reservation.balance = selected_camp.price
    
    # if params[:payment] == 'deposit'
    #   @payment_amount = 50
    # else
    #   @payment_amount = @reservation.camp.price
    # end

    if reservation.save

      begin
        SiteMailer.reservation_confirmation(reservation).deliver
        SiteMailer.reservation_notification(reservation).deliver
        redirect_to slug_path('home'), notice: "Reservation successful."
      rescue
        redirect_to slug_path('home'), notice: "Reservation was successful, but there was an e-mail error. Please contact saltwatercowgirls@gmail.com for payment information."
      end

    else
      render 'new'
    end

  end

  def update
    if reservation.save
      redirect_to reservations_path, notice: "Reservation updated.", reservation_id: reservation.id
    else
      render 'edit'
    end

  end

  def destroy
    reservation.destroy
    redirect_to reservations_path, message: "Reservation was deleted."

  end

  def search
    if search_results.empty?
      redirect_to root_path, error: "No matching records were found."
    else
      redirect_to search_results[0]
    end

  end

end
