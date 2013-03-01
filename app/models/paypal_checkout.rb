class PaypalCheckout
  includ ActiveMerchant::Billing
  include ActionView::Helpers::UrlHelper

  attr_reader :reservation, :ip

  def initialize(reservation, ip)
    @reservation = reservation
    @ip = ip
  end

  def url
    response = gateway.setup_purchase(reservation_price, purchase_params)
    gateway.redirect_url_for(response.token)
  end

  def reservation_price
    reservation.camp_price.to_f.to_cents
  end

  def purchase_params
    {
      ip: ip,
      return_url: review_url(reservation),
      cancel_return_url: root_url,
      subtotal: reservation.camp_price.to_f.to_cents,
      shipping: 0,
      handling: 0,
      tax: 0,
      allow_note: true,
      items: get_items(reservation)
    }
  end

  def gateway
    require 'pry'; binding.pry
    @gateway ||= PaypalExpressGateway.new(
      signature: PaypalLogin.signature,
      login: PaypalLogin.login,
      password: PaypalLogin.password
    )
  end

end
