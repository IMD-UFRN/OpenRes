# -*- encoding : utf-8 -*-
class NotifyUserMailer < ActionMailer::Base
  default from: "naoresponder@imd.ufrn.br"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notify_user_mailer.reservation_made.subject
  #

  def send_reservation_made(reservation)
    @reservation = reservation

    User.select { |u| @reservation.can_be_decided_over?(u) }.each do |user|
      reservation_made(@reservation, user).deliver
    end

  end

  private

  def reservation_made(reservation, user)
    @reservation = reservation

    mail to: user.email, subject: "[IMD- UFRN] Nova reserva"
  end
end
