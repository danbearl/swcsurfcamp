module PaypalExpressHelper

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
    {
      ip: request.remote_ip,
      token: params[:token],
      payer_id: params[:payer_id],
      subtotal: reservation.camp_price.to_f.to_cents,
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
        amount: reservation.camp_price.to_f.to_cents
      }
    ]
  end

end
