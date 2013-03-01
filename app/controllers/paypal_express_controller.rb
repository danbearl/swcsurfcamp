class PaypalExpressController < ApplicationController
  include PaypalLogin
  include PaypalExpressHelper

  expose(:reservation) { Reservation.find(params['reservation_id']) }

  def checkout
    new_url = PaypalCheckout.new(reservation, request.remote_ip).url
    redirect_to new_url
  end


  def review
    if params[:token].nil?
      redirect_to root_path, notice: 'Whoops! Something went wrong!'
    end

    gateway_response = @gateway.details_for(params[:token])

    unless gateway_response.success?
      redirect_to root_path, notice: "There was an error with the paypal purchase. Here's what PayPal said: #{gateway_response.message}"
      return

    end

    @order_info = get_order_info gateway_response, reservation
  end

  def purchase
    if params[:token].nil? or params[:payer_id].nil?
      redirect_to root_path, notice: "There was an error with the paypal purchase. Here's what PayPal said: #{gateway_response.message}"
      return

    end

    total_as_cents = reservation.camp_price.to_f.to_cents
    purchase_params = get_purchase_params reservation, request, params
    purchase = @gateway.purchase total_as_cents, purchase_params

    if purchase.success?
      reservation.payment_confirmed
      notice = "Thank you! Your reservation is now complete!"
    else
      notice = "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}"
    end

    redirect_to root_path, notice: notice, reservation_id: reservation.id
  end

end
