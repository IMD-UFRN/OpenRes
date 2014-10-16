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

      ReservationPolicy.approve(Reservation.find(reservation)).empty? ? s = s + 1 : f = f + 1

    end

    flash[:notice] = "#{s} reserva(s) aprovadas com sucesso."
    flash[:error] = "#{f} reserva(s) não puderam ser aprovadas." if (f > 0)

    render :js => 'window.location.reload()'

  end

  def suspend
    s = 0

    justification = Justification.new(justification_params)

    @reservations.each do |reservation|

      ReservationPolicy.suspend(Reservation.find(reservation), justification)
      s = s + 1

    end

    flash[:notice] = "#{s} reserva(s) suspensas com sucesso."

    redirect_to check_reservations_path(filter_by: "future")
  end

  def reject
    s = 0

    justification = Justification.new(justification_params)

    @reservations.each do |reservation|

      ReservationPolicy.reject(Reservation.find(reservation), justification)
      s = s + 1

    end

    flash[:notice] = "#{s} reserva(s) rejeitadas com sucesso."

    redirect_to check_reservations_path(filter_by: "future")
  end

  def cancel
    s = 0

    @reservations.each do |reservation|

      ReservationPolicy.cancel(Reservation.find(reservation))

       s = s + 1

    end

    flash[:notice] = "#{s} reserva(s) canceladas com sucesso."

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
