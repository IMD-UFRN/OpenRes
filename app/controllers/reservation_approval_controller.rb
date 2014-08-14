# -*- encoding : utf-8 -*-
class ReservationApprovalController < ApplicationController
  def index
    #@reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user))
    if params[:filter_by] == "future"
      pending_sector_reservations = Reservation.can_decide_over(current_user).pending.from_future.not_grouped
      approved_sector_reservations = Reservation.can_decide_over(current_user).approved.from_future.not_grouped
      rejected_sector_reservations = Reservation.can_decide_over(current_user).rejected.from_future.not_grouped
    elsif params[:filter_by] == "finished"
      pending_sector_reservations = Reservation.can_decide_over(current_user).pending.from_past.not_grouped
      approved_sector_reservations = Reservation.can_decide_over(current_user).approved.from_past.not_grouped
      rejected_sector_reservations = Reservation.can_decide_over(current_user).rejected.from_past.not_grouped
    else
      pending_sector_reservations = Reservation.can_decide_over(current_user).pending.not_grouped
      approved_sector_reservations = Reservation.can_decide_over(current_user).approved.not_grouped
      rejected_sector_reservations = Reservation.can_decide_over(current_user).rejected.not_grouped
      if params[:reservation_search]
        pending_sector_reservations = Reservation.filter(pending_sector_reservations, params[:reservation_search])
        approved_sector_reservations = Reservation.filter(approved_sector_reservations, params[:reservation_search])
        rejected_sector_reservations = Reservation.filter(rejected_sector_reservations, params[:reservation_search])
      end
    end

    @pending_sector_reservations  = ReservationDecorator.decorate_collection(pending_sector_reservations)
    @approved_sector_reservations = ReservationDecorator.decorate_collection(approved_sector_reservations)
    @rejected_sector_reservations = ReservationDecorator.decorate_collection(rejected_sector_reservations)

    @params = ReservationSearchDecorator.decorate(params[:reservation_search])
  end

  def approve
    ReservationPolicy.approve(Reservation.find(params[:reservation_id]))
    redirect_to check_reservations_path
  end

  def reject
    @justification = Justification.new(justification_params)

    ReservationPolicy.reject(Reservation.find(params[:reservation_id]), @justification)
    redirect_to check_reservations_path
  end

  def suspend
    @justification = Justification.new(justification_params)

    ReservationPolicy.suspend(Reservation.find(params[:reservation_id]), @justification)
    redirect_to check_reservations_path
  end

  def cancel
    ReservationPolicy.cancel(Reservation.find(params[:reservation_id]))
    redirect_to reservations_path(filter_by: "future"), notice: "Reserva cancelada com sucesso."
  end

  def justify_status
    @justification = Justification.new

    respond_to do |format|
      format.html
      format.js
    end
  end


  def justification_params
    params.require(:justification).permit(:reason).
      merge(user_id: current_user.id, reservation_id: params[:reservation_id])
  end
end
