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

  def send_vehicle_reservation_made(reservation)
    @reservation = reservation

    User.where(role:"admin").each do |user|
      reservation_made(@reservation, user).deliver
    end

  end

  def send_reservation_to_class_monitor(reservation)
    @reservation = reservation

    @reservation.place.class_monitors.each do |monitor|
      reservation_made_to_class_monitor(@reservation, monitor).deliver
    end

  end

  def send_canceled_mail(reservation)
    @reservation = reservation

    User.select { |u| @reservation.can_be_decided_over?(u) }.each do |user|
      reservation_canceled(@reservation, user).deliver
    end

  end

  def send_canceled_group_mail(reservation_group)
    @reservation_group = reservation_group

    User.select { |u| @reservation_group.can_be_decided_over?(u) }.each do |user|
      reservation_group_canceled(@reservation_group, user).deliver
    end

  end

  private

  def reservation_made(reservation, user)
    @reservation = reservation
    @url  = 'http://espacos.imd.ufrn.br'

    mail to: user.email, subject: "[IMD- UFRN] Nova reserva"
  end

  def reservation_made_to_class_monitor(reservation, user)
    @reservation = reservation
    @url  = 'http://espacos.imd.ufrn.br'

    mail to: user.email, subject: "[IMD- UFRN] Reserva em Sala de Monitoria"
  end


  def reservation_canceled(reservation, user)
    @reservation = reservation

    mail to: user.email, subject: "[IMD- UFRN] Reserva cancelada"
  end

  def reservation_group_canceled(reservation_group, user)
    @reservation_group = reservation_group

    mail to: user.email, subject: "[IMD- UFRN] Reserva cancelada"
  end

end
