# -*- encoding : utf-8 -*-
class ReservationGroupDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def places
    object.places.map do |place|
      link_to(place.code, place)
    end.join(", ").html_safe
  end

  def place_name
    object.place.full_name
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
    return " " if (object.status == 'approved') || !object.can_be_decided_over?(current_user) || object.confirmed_at.nil?

    btn_class = "btn-small btn-normal"

    btn_class += " muted" if object.has_conflicts?

    link_to 'Aprovar', reservation_group_approve_path(reservation_group), method: :post,  data: { confirm: 'Você tem certeza que deseja aprovar esta reserva múltipla?' }, class: btn_class, disabled: object.has_conflicts?
  end

  def reject_link
    return if object.status == 'rejected' || !object.can_be_decided_over?(current_user) || object.confirmed_at.nil?

    link_to 'Rejeitar', justify_reject_group_path(reservation_group),
      {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class:"btn-small btn-normal"}

  end

  def suspend_link
    return if object.status == 'pending' || !object.can_be_decided_over?(current_user) || object.confirmed_at.nil?


    link_to 'Suspender', justify_suspend_group_path(reservation_group),
     {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window',class:"btn-small btn-normal"}

  end

  def approver_links
    approve_link + " " + reject_link + " " +suspend_link
  end

  def cancel_link
    return if object.status == 'canceled' || object.status == "rejected" || !(object.user == current_user || object.created_by == current_user) || object.past?


    link_to 'Cancelar Reserva', reservation_group_cancel_path(reservation_group), method: :post,  data: { confirm: 'Você tem certeza que deseja cancelar esta reserva?' }, class:"btn-small btn-normal"
  end

  def edit_link
    return if object.status == 'canceled' || object.status == "rejected" ||  !(object.user == current_user || object.created_by == current_user) || object.past?

    link_to "Editar Reserva", edit_reservation_group_path, class: "btn-small btn-normal"
  end

  def has_conflicts?
    return "Sim" if object.has_conflicts?
    "Não"
  end

  def responsible
    return object.responsible unless object.responsible.blank?
    link_to object.user.name, object.user
  end

  def user
    link_to object.user.name, object.user
  end

  def save_button
    link_to "Salvar Reserva", reservation_group_confirm_path(reservation_group), method: :post, class:"btn btn-success" if object.confirmed_at.nil?
  end

  def new_reservation_button
    link_to "Adicionar Reserva Simples", add_reservation_path(reservation_group), class:"btn btn-success" if object.confirmed_at.nil?
  end

  def message

    hint_message= <<-msg

    <div class= "alert alert-warning">
      Sua reserva ainda não foi cadastrada. <br>
      Caso sua reserva apresente conflitos, clique em "Adicionar Reserva Simples" para adicionar uma reserva que resolva o conflito. Em seguida, exclua sua reserva conflitante.
      <br>
      Satisfeito com suas reservas, clique em "Salvar Reserva".
      <br>
      Caso não deseje confirmar esta reserva, clique em "Cancelar Reserva"
      <br>
      Esta reserva continuará acessível na sua tela de reservas caso você deixe esta tela.
      <br>
      Somente após clicar em "Salvar Reserva" sua reserva estará visível para os Administradores do sistema.
    </div>
msg
    return hint_message.html_safe if object.confirmed_at.nil?

  end
end
