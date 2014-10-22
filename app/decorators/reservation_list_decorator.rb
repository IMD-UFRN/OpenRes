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

    return "" unless @actions.include?("approve") && ReservationAuth.can_approve_list?(current_user, object)

    return link_to 'Aprovar Selecionadas', mass_approve_path,  data: { confirm: 'Você tem certeza que deseja aprovar as reservas selecionadas?', reservations: ""}, class:"btn-small btn-normal mass-action-btn"
  end

  def reject_link
    return "" unless @actions.include?("reject") && ReservationAuth.can_reject_list?(current_user, object)

    return link_to 'Rejeitar Selecionadas', justify_mass_reject_path,
      {'data-toggle' =>  "modal", 'data-target' => '#modal-window', class:"btn-small btn-normal mass-action-btn", "data-reservations" => "" }
  end

  def suspend_link
    return "" unless @actions.include?("suspend") && ReservationAuth.can_suspend_list?(current_user, object)

    return link_to 'Suspender Selecionadas', justify_mass_suspend_path,
     {'data-toggle' =>  "modal", 'data-target' => '#modal-window',class:"btn-small btn-normal mass-action-btn", "data-reservations" => "" }
  end

  def cancel_link
    return "" unless @actions.include?("cancel") && ReservationAuth.can_cancel_list?(current_user, object)

    return link_to 'Cancelar Selecionadas', mass_cancel_path,  data: { confirm: 'Você tem certeza que deseja cancelar as reservas selecionadas?', reservations: "" }, class:"btn-small btn-normal mass-action-btn"

  end

  def delete_link
    return "" unless @actions.include?("delete") && ReservationAuth.can_delete_list?(current_user, object)

    return link_to 'Excluir Selecionadas', mass_delete_path, data: { confirm: 'Você tem certeza que deseja excluir as reservas selecionadas?', reservations: "" }, class:"btn-small btn-normal mass-action-btn"
  end

  def mass_actions
    (approve_link + " " + suspend_link + " " + reject_link + " " + cancel_link + " " + delete_link).html_safe
  end
end
