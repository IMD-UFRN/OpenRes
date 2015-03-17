# -*- encoding : utf-8 -*-
class NotifyUserMailer < ActionMailer::Base
  default from: "naoresponder@imd.ufrn.br"

  def reservation_made(reservation, user)
    @reservation = reservation
    @url  = 'http://espacos.imd.ufrn.br'

    mail to: user.email, subject: "[IMD- UFRN] Nova reserva"
  end

  def vehicle_reservation_made(reservation, user)
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
