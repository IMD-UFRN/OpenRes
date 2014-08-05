# -*- encoding : utf-8 -*-
class ReservationDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  #talvez internacionalizar isso?
  def status
    return 'Aprovada' if object.status == 'approved'
    return 'Rejeitada' if object.status == 'rejected'
    return 'Pendente' if object.status == 'pending'
  end

  def has_conflicts?
    return "Sim" if object.has_conflicts?
    return "Não"
  end

  def begin_time
    object.begin_time.strftime("%H:%M")
  end

  def end_time
    object.end_time.strftime("%H:%M")
  end

  def created_at
    object.created_at.strftime("%d/%m/%Y - %H:%M")
  end

  def date
    object.date.strftime("%d/%m/%Y")
  end

  def week_day
    days = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]
    days[object.date.wday]
  end

  def user
    link_to(object.user.name, object.user)
  end

  def place
    link_to(object.place.full_name, object.place)
  end

  def top_rect
    @top_rect ||= (object.begin_time.hour * 60 + object.begin_time.min) * 0.5
  end

  def room_type
    link_to(object.place.room_type.name, object.place.room_type)
  end

  def rect_height
    ((object.end_time.hour * 60 + object.end_time.min) * 0.5) - top_rect
  end

  def random_color
    "%06x" % (rand * 0xffffff)
  end

  def details_link
    link_to 'Detalhes', reservation_path(reservation), class:"btn-small btn-normal"
  end

  def approve_link
    return if object.status == 'approved' || !object.can_be_decided_over?(current_user)

    link_to 'Aprovar', reservation_approve_path(reservation), method: :post,  data: { confirm: 'Você tem certeza que deseja aprovar esta reserva?' }, class:"btn-small btn-normal"

  end

  def reject_link
    return if object.status == 'rejected' || !object.can_be_decided_over?(current_user)


    link_to 'Rejeitar', justify_reject_path(reservation),
      {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class:"btn-small btn-normal"}

  end

  def suspend_link
    return if object.status == 'pending' || !object.can_be_decided_over?(current_user)


    link_to 'Suspender', justify_suspend_path(reservation),
     {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window',class:"btn-small btn-normal"}

  end

  def approver_links
      approve_link + " " + suspend_link + " " + reject_link + " " + cancel_link
  end

  def conflict_class
    "conflicted_reservation" if  object.has_conflicts?
  end

  def responsible
    return object.responsible unless object.responsible.nil? || object.responsible == ""
    user
  end

  def cancel_link
    return if object.status == 'canceled' || !object.user == current_user


    link_to 'Cancelar', reservation_cancel_path(reservation), method: :post,  data: { confirm: 'Você tem certeza que deseja cancelar esta reserva?' }, class:"btn-small btn-normal"
  end
end
