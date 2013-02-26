module PaypalExpressHelper
  def get_setup_purchase_params(reservation, request)
    
    return to_cents(reservation.camp_price.to_f), {
      ip: request.remote_ip,
      return_url: url_for(action: 'review', only_path: false, reservation_id: reservation.id),
      cancel_return_url: root_url,
      subtotal: to_cents(reservation.camp_price.to_f),
      shipping: 0,
      handling: 0,
      tax: 0,
      allow_note: true,
      items: get_items(reservation)
    }
  end

  def get_order_info(gateway_response, reservation)
    {
      email: gateway_response.email,
      name: gateway_response.name,
      gateway_details: {
        token: gateway_response.token,
        payer_id: gateway_response.payer_id
      },
      subtotal: reservation.camp_price,
      shipping: 0,
      total: reservation.camp_price
    }
  end

  def get_purchase_params(reservation, request, params)
    return to_cents(reservation.camp_price.to_f), {
      ip: request.remote_ip,
      token: params[:token],
      payer_id: params[:payer_id],
      subtotal: to_cents(reservation.camp_price.to_f),
      shipping: 0,
      handling: 0,
      tax: 0,
      items: get_items(reservation)
    }
  end

  def get_items(reservation)
    [
      {
        name: "#{reservation.camp_type.capitalize} starting on #{reservation.camp_start_date.to_formatted_s(:long)}",
        number: 1,
        quantity: 1,
        amount: to_cents(reservation.camp_price.to_f)
      }
    ]
  end

  def to_cents(money)
    (money*100).round
  end

end