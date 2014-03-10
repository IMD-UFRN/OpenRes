# -*- encoding : utf-8 -*-
class ReservationApprovalMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_approval_mailer.approved_mail.subject
  #
  def approved_mail(reservation)
    @greeting = "Hi"
    @reservation = reservation

    mail to: @reservation.user.email, subject: "[IMD- UFRN] Situação de reserva para sala #{@reservation.place.name}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_approval_mailer.rejected_mail.subject
  #
  def rejected_mail(reservation, justification)
    @greeting = "Hi"
    @justification = justification
    @reservation = reservation

    mail to: @reservation.user.email, subject: "[IMD- UFRN] Situação de reserva para sala #{@reservation.place.name}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_approval_mailer.suspended_mail.subject
  #
  def suspended_mail(reservation, justification)
    @greeting = "Hi"
    @reservation = reservation
    @justification = justification

    mail to: @reservation.user.email, subject: "[IMD- UFRN] Situação de reserva para sala #{@reservation.place.name}"
  end

  def approved_group_mail(reservation_group)
    @greeting = "Hi"
    @reservation_group = reservation_group

    mail to: @reservation_group.user.email, subject: "[IMD- UFRN] Situação de reserva múltipla para sala #{@reservation_group.place.name}"
  end

  def rejected_group_mail(reservation_group, justification)
    @reservation_group = reservation_group
    @justification = justification

    mail to: @reservation_group.user.email, subject: "[IMD- UFRN] Situação de reserva múltipla para sala #{@reservation_group.place.name}"
  end

  def suspended_group_mail(reservation_group, justification)
    @reservation_group = reservation_group
    @justification = justification

    mail to: @reservation_group.user.email, subject: "[IMD- UFRN] Situação de reserva múltipla para sala #{@reservation_group.place.name}"
  end
end
