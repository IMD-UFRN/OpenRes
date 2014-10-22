# -*- encoding : utf-8 -*-
class ReservationDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  #talvez internacionalizar isso?
  def status
    return 'Aprovada' if object.status == 'approved'
    return 'Rejeitada' if object.status == 'rejected'
    return 'Pendente' if object.status == 'pending'
    return 'Cancelada' if object.status == 'canceled'
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

  def created_by
    link_to(object.created_by.name, object.created_by)
  end

  def place
    link_to(object.place.full_name, object.place)
  end

  def room_type
    link_to(object.place.room_type.name, object.place.room_type)
  end

  def details_link
    link_to 'Detalhes', reservation_path(reservation), class:"btn-small btn-normal"
  end

  def approve_link
    return unless ReservationAuth.can_approve?(current_user, reservation)

    link_to 'Aprovar', reservation_approve_path(reservation), method: :post,  data: { confirm: 'Você tem certeza que deseja aprovar esta reserva?' }, class:"btn-small btn-normal"

  end

  def reject_link
    return unless ReservationAuth.can_reject?(current_user, reservation)

    link_to 'Rejeitar', justify_reject_path(reservation),
      {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class:"btn-small btn-normal"}

  end

  def suspend_link
    return unless ReservationAuth.can_suspend?(current_user, reservation)

    link_to 'Suspender', justify_suspend_path(reservation),
     {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window',class:"btn-small btn-normal"}

  end

  def edit_link
    return unless ReservationAuth.can_edit?(current_user, reservation)

    link_to 'Editar Informações desta Reserva', edit_reservation_path(object), class: "btn-small btn-normal"
  end

  def cancel_link
    return unless ReservationAuth.can_cancel?(current_user, reservation)

    link_to 'Cancelar Reserva', reservation_cancel_path(reservation), method: :post,  data: { confirm: 'Você tem certeza que deseja cancelar esta reserva?' }, class:"btn-small btn-normal"
  end

  def delete_link
   return unless ReservationAuth.can_delete?(current_user, reservation)

    link_to 'Excluir', object, method: :delete, data: { confirm: 'Você tem certeza que deseja excluir esta reserva?' }, class:"btn-small btn-normal"
  end

  def conflict_class
    "conflicted_reservation" if  object.has_conflicts? and not object.status.in? %w(canceled rejected)
  end

  def responsible
    return object.responsible unless object.responsible.nil? || object.responsible == ""
    user
  end

  def cancel_or_suspend_reason
    return object.justification.try(:reason) || "--"
  end

end
