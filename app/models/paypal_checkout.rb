class PaypalCheckout < ActionView::Base
  include ActiveMerchant::Billing
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionDispatch::Routing
  include Rails.application.routes.url_helpers

  attr_reader :reservation, :ip

  def initialize(reservation, ip, host, params)
    @reservation = reservation
    @ip = ip
    @payment_amount = params[:payment_amount]
    @payment_type = params[:payment_type]
    @token = params[:token]
    default_url_options[:host] = host
    gateway
  end

  def url
    response = @gateway.setup_purchase(payment_price, purchase_params)
    Rails.logger.info response.inspect
    @gateway.redirect_url_for(response.token)
  end

  def payment_price
    @payment_amount.to_f.to_cents
  end

  def purchase_params
    {
      ip: ip,
      return_url: review_url,
      cancel_return_url: url_for(controller: 'paypal_express', action: 'cancel',only_path: false, reservation_id: @reservation.id),
      subtotal: payment_price,
      shipping: 0,
      handling: 0,
      tax: 0,
      allow_note: true,
      items: get_items
    }
  end

  def gateway
    @gateway ||= PaypalExpressGateway.new(
      signature: PaypalLogin.signature,
      login: PaypalLogin.login,
      password: PaypalLogin.password
    )
  end

  def review_url
    url_for(controller: 'paypal_express',action:'review', only_path: false, reservation_id: @reservation.id, payment_type: @payment_type, payment_amount: @payment_amount)
  end

  def get_items
    [{
      name: "Saltwater Cowgirls Surfcamp #{@reservation.camp.camp_type.capitalize} starting on #{@reservation.camp.start_date.to_formatted_s(:long)}",
      number: 1,
      quantity: 1,
      amount: payment_price
    }]
  end

  def gateway_response
    @gateway.details_for(@token)
  end

  def purchase(total_as_cents, purchase_params)
    @gateway.purchase total_as_cents, purchase_params
  end

end
