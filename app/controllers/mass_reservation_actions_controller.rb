# -*- encoding : utf-8 -*-
class MassReservationActionsController < ApplicationController

  def approve

    reservations = params[:reservations].split(",").delete_if{|k| params[:reservations][k].blank? }.map(&:to_i)

    s = 0
    f = 0

    reservations.each do |reservation|

      ReservationPolicy.approve(Reservation.find(reservation)).empty? ? s = s + 1 : f = f + 1

    end

    flash[:notice] = "#{s} reserva(s) aprovadas com sucesso."
    flash[:error] = "#{f} reserva(s) não puderam ser aprovadas." if (f > 0)

    render :js => 'window.location.reload()'

  end

  def suspend

  end

end
