# -*- encoding : utf-8 -*-
class VehicleReservationDecorator < Draper::Decorator
  delegate_all

  include Draper::LazyHelpers


  def details_link
    link_to icon("file-text-o") + " Detalhes", object, class: "btn btn-normal btn-sm"
  end

  def approve_link
    link_to icon("check-square-o") + " Aprovar", vehicle_reservation_approve_path(object.id), class: "btn btn-normal btn-sm", method: "post"
  end

  def suspend_link
    link_to icon("exclamation-circle") + " Suspender", justify_suspend_for_vehicle_reservation(object), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class: "btn btn-normal btn-sm"}
  end

  def reject_link
    link_to icon("ban") + " Rejeitar", justify_reject_for_vehicle_reservation(object), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class: "btn btn-normal btn-sm"}
  end

  def cancel_link
    link_to icon("close") + " Cancelar", object, class: "btn btn-normal btn-sm"
  end

  def date
    object.date.strftime("%d/%m/%Y")
  end

  def begin_time
    object.begin_time.strftime("%H:%M")
  end

  def end_time
    object.end_time.strftime("%H:%M")
  end

  def vehicle
    link_to object.vehicle.full_name, object.vehicle
  end

  def has_conflicts?
    object.has_conflicts? ? "Sim" : "Não"
  end

  def status
    I18n.t(object.status)
  end

  def responsible
    "ME IMPLEMENTE"
  end

  def conflict_class
    "conflicted_reservation" if  object.has_conflicts? and not object.status.in? %w(canceled rejected)
  end



end
