module PaypalExpressHelper

  def get_order_info(gateway_response, payment_amount)
    {
      email: gateway_response.email,
      name: gateway_response.name,
      gateway_details: {
        token: gateway_response.token,
        payer_id: gateway_response.payer_id
      },
      subtotal: payment_amount.to_f,
      shipping: 0,
      total: payment_amount.to_f
    }
  end

  def get_purchase_params(request, params)
    {
      ip: request.remote_ip,
      token: params[:token],
      payer_id: params[:payer_id],
      subtotal: params[:payment_amount].to_f.to_cents,
      shipping: 0,
      handling: 0,
      tax: 0,
      items: get_items(reservation, params[:payment_amount])
    }
  end

  def get_items(reservation, payment_amount)
    [
      {
        name: "#{reservation.camp.camp_type.capitalize} starting on #{reservation.camp.start_date.to_formatted_s(:long)}",
        number: 1,
        quantity: 1,
        amount: payment_amount.to_f.to_cents
      }
    ]
  end

end
