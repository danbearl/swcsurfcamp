class PaypalExpressController < ApplicationController
  include PaypalLogin
  include PaypalExpressHelper

  expose(:reservation) { Reservation.find(params['reservation_id']) }

  def checkout
    new_url = PaypalCheckout.new(reservation, request.remote_ip, request.env['HTTP_HOST'], params).url
    redirect_to new_url
  end

  def cancel
    reservation.destroy

    redirect_to root_path, notice: "Reservation cancelled."
  end


  def review
    if params[:token].nil?
      redirect_to root_path, notice: 'Whoops! Something went wrong!'
    end

    gateway_response = PaypalCheckout.new(reservation, request.remote_ip, request.env['HTTP_HOST'], params).gateway_response

    unless gateway_response.success?
      redirect_to root_path, notice: "There was an error with the paypal purchase. Here's what PayPal said: #{gateway_response.message}"
      return

    end

    @order_info = get_order_info(gateway_response, params[:payment_amount])
    @payment_type = params[:payment_type]
  end

  def purchase
    if params[:token].nil? or params[:payer_id].nil?
      redirect_to root_path, notice: "There was an error with the paypal purchase. Here's what PayPal said: #{gateway_response.message}"
      return

    end

    total_as_cents = params[:payment_amount].to_f.to_cents
    purchase_params = get_purchase_params(request, params)
    purchase = PaypalCheckout.new(reservation, request.remote_ip, request.env['HTTP_HOST'], params).purchase(total_as_cents, purchase_params)

    if purchase.success?
      reservation.payment_confirmed
      reservation.balance -= params[:payment_amount].to_f

      reservation.save
      notice = "Thank you! Your reservation is now complete!"

      if params[:payment_type] == "initial"
        SiteMailer.reservation_confirmation(reservation).deliver
        SiteMailer.reservation_notification(reservation).deliver
      else
        SiteMailer.reservation_payment_confirmation(reservation).deliver
        SiteMailer.reservation_payment_notification(reservation).deliver
      end

    else
      notice = "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Here's what Paypal said: #{purchase.message}"
      reservation.destroy
    end

    redirect_to root_path, notice: notice, reservation_id: reservation.id
  end

end
