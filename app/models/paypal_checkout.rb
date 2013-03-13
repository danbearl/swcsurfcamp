class PaypalCheckout < ActionView::Base
  include ActiveMerchant::Billing
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionDispatch::Routing
  include Rails.application.routes.url_helpers

  attr_reader :reservation, :ip

  def initialize(reservation, ip, host)
    @reservation = reservation
    @ip = ip
    default_url_options[:host] = host
    gateway
  end

  def url
    response = @gateway.setup_purchase(reservation_price, purchase_params)
    Rails.logger.info response.inspect
    @gateway.redirect_url_for(response.token)
  end

  def reservation_price
    @reservation.camp_price.to_f.to_cents
  end

  def purchase_params
    {
      ip: ip,
      return_url: review_url,
      cancel_return_url: root_url,
      subtotal: @reservation.camp_price.to_f.to_cents,
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
    url_for(controller: 'paypal_express',action:'review', only_path: false, reservation_id: @reservation.id)
  end

  def get_items
    [{
      name: "Saltwater Cowgirls Surfcamp #{@reservation.camp_type.capitalize} starting on #{@reservation.camp_start_date.to_formatted_s(:long)}",
      number: 1,
      quantity: 1,
      amount: @reservation.camp_price.to_f.to_cents
    }]
  end

end
