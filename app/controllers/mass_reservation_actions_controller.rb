class MassReservationActionsController < ApplicationController

  def approve

    reservations = params[:reservations].split(",").delete_if{|k| params[:reservations][k].blank? }.map(&:to_i)

    reservations.each do |reservation|
      ReservationPolicy.approve(Reservation.find(reservation))
    end

    flash[:notice] = "Reservas aprovadas com sucesso."

    render :js => 'window.location.reload()'

  end

end
