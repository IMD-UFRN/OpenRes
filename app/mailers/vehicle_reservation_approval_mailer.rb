# -*- encoding : utf-8 -*-
class VehicleReservationApprovalMailer < ActionMailer::Base

  default from: "naoresponder@imd.ufrn.br"

  def approved_mail(reservation)
    @reservation = reservation

    mail to: @reservation.user.email, subject: "[IMD- UFRN] Situação de reserva para veículo #{@reservation.vehicle.full_name}"
  end

  def rejected_mail(reservation, justification)
    @justification = justification
    @reservation = reservation

    mail to: @reservation.user.email, subject: "[IMD- UFRN] Situação de reserva para veículo #{@reservation.vehicle.full_name}"
  end

  def suspended_mail(reservation, justification)

    @reservation = reservation
    @justification = justification

    mail to: @reservation.user.email, subject: "[IMD- UFRN] Situação de reserva para veículo #{@reservation.vehicle.full_name}"
  end

end
