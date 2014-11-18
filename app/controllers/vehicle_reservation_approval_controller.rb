# -*- encoding : utf-8 -*-
class VehicleReservationApprovalController < ApplicationController

  def approve
    reservation = VehicleReservation.find(params[:id])

    conflicts = VehicleReservationPolicy.approve(reservation)

    if (conflicts.empty?)
      flash[:notice] = "Reserva aprovada com sucesso."
    else
      flash[:error] = "Esta reserva possui conflitos e não pode ser aprovada até que estejam resolvidos."
    end

    redirect_to vehicle_reservations_path(filter_by: "future")
  end

  def reject

    @justification = VehicleReservationJustification.new(justification_params)

    reservation = VehicleReservation.find(params[:id])

    VehicleReservationPolicy.reject(reservation, @justification)

    flash[:notice] = "Reserva rejeitada com sucesso."

    redirect_to vehicle_reservations_path(filter_by: "future")

  end

  def suspend
    @justification = VehicleReservationJustification.new(justification_params)

    reservation = VehicleReservation.find(params[:id])

    VehicleReservationPolicy.suspend(reservation, @justification)

    flash[:notice] = "Reserva suspensa com sucesso."

    redirect_to vehicle_reservations_path(filter_by: "future")
  end

  def justify_status
    @justification = VehicleReservationJustification.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def justification_params
    params.require(:justification).permit(:reason).merge(vehicle_reservation_id: params[:id])
  end

end
