# -*- encoding : utf-8 -*-
class ReservationGroupDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def place
    link_to object.place.name,object.place
  end

  def begin_date
    object.begin_date.strftime("%d/%m/%Y")
  end

  def end_date
    object.end_date.strftime("%d/%m/%Y")
  end

  def days
    days = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]
    my_days = ""
    object.days.each do |day|
      my_days.concat(days[day]+", ")
    end

    my_days[0..-3]
  end

  def status
    my_status={
      "pending"=>"Pendente",
      "rejected"=>"Rejeitada",
      "approved"=>"Aprovada",
      "canceled"=>"Cancelada",
      "partially approved" => "Aprovada Parcialmente",
      "partially pending" => "Pendente Parcialmente",
    }

    return my_status[object.status]
  end


  def approve_link
    return " " if (object.status == 'approved') || !object.can_be_decided_over?(current_user)

    btn_class = "btn-small btn-normal"

    btn_class += " muted" if object.has_conflicts?

    link_to 'Aprovar', reservation_group_approve_path(reservation_group), method: :post,  data: { confirm: 'Você tem certeza que deseja aprovar esta reserva múltipla?' }, class: btn_class, disabled: object.has_conflicts?
  end

  def reject_link
    return if object.status == 'rejected' || !object.can_be_decided_over?(current_user)

    link_to 'Rejeitar', justify_reject_group_path(reservation_group),
      {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class:"btn-small btn-normal"}

  end

  def suspend_link
    return if object.status == 'pending' || !object.can_be_decided_over?(current_user)


    link_to 'Suspender', justify_suspend_group_path(reservation_group),
     {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window',class:"btn-small btn-normal"}

  end

  def approver_links
    approve_link + " " + reject_link + " " +suspend_link
  end

  def cancel_link
    return if object.status == 'canceled' || object.status == "rejected" || !(object.user == current_user) || object.past?


    link_to 'Cancelar Reserva', reservation_group_cancel_path(reservation_group), method: :post,  data: { confirm: 'Você tem certeza que deseja cancelar esta reserva?' }, class:"btn-small btn-normal"
  end


  def has_conflicts?
    return "Sim" if object.has_conflicts?
    "Não"
  end

  def responsible
    return object.responsible unless object.responsible.nil? || object.responsible == ""
    link_to user.name, user
  end

end
