class SiteMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM']
  default to: ENV['DEFAULT_TO']

  def reservation_confirmation(reservation)
    @reservation = reservation

    mail(to: @reservation.email, subject: "Saltwater Cowgirls Surfcamp Reservation Confirmation")
  end
  
  def reservation_notification(reservation)
    @reservation = reservation

    mail(subject: "New Reservation for Saltwater Cowgirls Surfcamp")
  end

  def reservation_payment_confirmation(reservation)
    @reservation = reservation

    mail(subject: "Saltwater Cowgirls Surfcamp Payment Confirmation")
  end

  def reservation_payment_notification(reservation)
    @reservation = reservation

    mail(subject: "New Payment for Saltwater Cowgirls Surfcamp")
  end
end
