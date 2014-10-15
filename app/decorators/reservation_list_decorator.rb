# -*- encoding : utf-8 -*-
# app/decorators/articles_decorator.rb
class ReservationListDecorator < Draper::CollectionDecorator

  include Draper::LazyHelpers

  attr_accessor :actions

  def self.initialize_decorator(reservations, *actions)
    list = decorate reservations
    list.actions = actions
    return list
  end


  def approve_link
    return link_to 'Aprovar', mass_approve_path,  data: { confirm: 'Você tem certeza que deseja aprovar esta reserva?', reservations: ""}, class:"btn-small btn-normal mass-action-btn" if @actions.include? "approve"
    return ""
  end

  def reject_link
    return link_to 'Rejeitar', justify_mass_reject_path,
      {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class:"btn-small btn-normal mass-action-btn", "data-reservations" => "" } if @actions.include? "reject"
    return ""
  end

  def suspend_link
    return link_to 'Suspender', "#",
     {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window',class:"btn-small btn-normal mass-action-btn", "data-reservations" => "" } if @actions.include? "suspend"
    return ""
  end

  def cancel_link
    return link_to 'Cancelar Reserva', "#", method: :post,  data: { confirm: 'Você tem certeza que deseja cancelar esta reserva?', reservations: "" }, class:"btn-small btn-normal mass-action-btn" if @actions.include? "cancel"
    return ""
  end

  def delete_link
    return link_to 'Excluir', "#", method: :delete, data: { confirm: 'Você tem certeza que deseja excluir esta reserva?', reservations: "" }, class:"btn-small btn-normal mass-action-btn" if @actions.include? "delete"
    return ""
  end

  def mass_actions
    (approve_link + " " + suspend_link + " " + reject_link + " " + cancel_link + " " + delete_link).html_safe
  end
end
