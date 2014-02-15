# -*- encoding : utf-8 -*-
class ReservationApprovalController < ApplicationController
  def index
    #@reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user))
    if params[:filter_by] == "future"
      @pending_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).pending.from_future)
      @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).approved.from_future)
      @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).rejected.from_future)
    elsif params[:filter_by] == "finished"
      @pending_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).pending.from_past)
      @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).approved.from_past)
      @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).rejected.from_past)
    else      
      @pending_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).pending)
      @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).approved)
      @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).rejected)
    end
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
