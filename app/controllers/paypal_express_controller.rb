class PaypalExpressController < ApplicationController
  include PaypalLogin
  before_filter :assigns_gateway

  include ActiveMerchant::Billing
  include PaypalExpressHelper

  expose(:reservation) { Reservation.find(params['reservation_id']) }

  def checkout
    total_as_cents, setup_purchase_params = get_setup_purchase_params reservation, request

    setup_response = @gateway.setup_purchase(total_as_cents, setup_purchase_params)
    redirect_to @gateway.redirect_url_for(setup_response.token)

  end

  def review
    if params[:token].nil?
      redirect_to root_path, notice: 'Whoops! Something went wrong!'
      return

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

    total_as_cents, purchase_params = get_purchase_params reservation, request, params
    purchase = @gateway.purchase total_as_cents, purchase_params

    if purchase.success?
      reservation.payment_confirmed
      notice = "Thank you! Your reservation is now complete!"
    else
      notice = "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}"
    end
    
    redirect_to root_path, notice: notice, reservation_id: reservation.id
  end

  private
  
  def assigns_gateway
    @gateway ||= PaypalExpressGateway.new(
      signature: PaypalLogin.signature,
      login: PaypalLogin.login,
      password: PaypalLogin.password
    )

  end
  
end
