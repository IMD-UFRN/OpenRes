# -*- encoding : utf-8 -*-
class MassReservationActionsController < ApplicationController

  before_action :set_reservations

  def set_reservations
    r = params[:reservations] || params[:justification][:reservations]

    @reservations = r.split(",").delete_if{|k| r[k].blank? }.map(&:to_i)
  end

  def approve
    s = 0
    f = 0

    @reservations.each do |reservation|

      ReservationPolicy.approve(current_user, Reservation.find(reservation)).empty? ? s = s + 1 : f = f + 1

    end

    flash[:notice] = "#{s} reserva(s) aprovada(s) com sucesso."
    flash[:error] = "#{f} reserva(s) não puderam ser aprovada(s)." if (f > 0)

    render :js => 'window.location.reload()'

  end

  def suspend
    s = 0

    justification = Justification.new(justification_params)

    @reservations.each do |reservation|

      ReservationPolicy.suspend(current_user, Reservation.find(reservation), justification)
      s = s + 1

    end

    flash[:notice] = "#{s} reserva(s) suspensa(s) com sucesso."

    redirect_to check_reservations_path(filter_by: "future")
  end

  def reject
    s = 0

    @reservations.each do |reservation|

      justification = Justification.new(justification_params)

      justification.reservation_id = reservation

      ReservationPolicy.reject(current_user, Reservation.find(reservation), justification)
      s = s + 1

    end

    flash[:notice] = "#{s} reserva(s) rejeitada(s) com sucesso."

    redirect_to check_reservations_path(filter_by: "future")
  end

  def cancel
    s = 0

    @reservations.each do |reservation|

      ReservationPolicy.cancel(current_user, Reservation.find(reservation))

       s = s + 1

    end

    flash[:notice] = "#{s} reserva(s) cancelada(s) com sucesso."

    render :js => 'window.location.reload()'

  end

  def delete
    s = 0

    reservation_group = Reservation.find(@reservations.first).reservation_group

    if reservation_group

      if @reservations.length == reservation_group.reservations.length
        flash[:error] = "Você não pode excluir todas as reservas de uma reserva em grupo. Caso deseje fazer isso, cancele esta reserva múltipla."

        render :js => 'window.location.reload()'

        return
      end

    end

    @reservations.each do |reservation|

      s = s + 1 if (Reservation.find(reservation).destroy)

    end

    flash[:notice] = "#{s} reserva(s) excluída(s) com sucesso."

    render :js => 'window.location.reload()'

  end

  def justify_mass_status
    @justification = Justification.new

    respond_to :js
  end

  def justification_params
    params.require(:justification).permit(:reason).
      merge(user_id: current_user.id, reservation_id: params[:reservation_id])
  end

end
