module PaypalExpressHelper
  def get_setup_purchase_params(reservation, request)

    return to_cents(reservation.camp_price.to_f*1.03), {
      ip: request.remote.ip,
      return_url: url_for(controller: 'reservations', action: 'show', only_path: false),
      cancel_return_url: home_url,
      subtotal: to_cents(reservation.camp_price.to_f*1.03),
      shipping: 0,
      handling: 0,
      tax: 0,
      allow_note: true,
      items: get_item(reservation)
    }

  end

  def get_items(camp)
    [{
      name: "#{reservation.camp_type.capitalize} starting on #{reservation.camp_start_date}",
      amount: reservation.camp_price
    }]

  end

  def to_cents(money)
    (money*100).round

  end

end
