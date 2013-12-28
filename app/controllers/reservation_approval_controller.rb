class ReservationApprovalController < ApplicationController
  def index
    @reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user))
  end

  def approve
    ReservationPolicy.approve(Reservation.find(params[:reservation_id]))
    redirect_to check_reservations_path
  end

  def reject
    ReservationPolicy.reject(Reservation.find(params[:reservation_id]))
    redirect_to check_reservations_path
  end

  def set_pending
    ReservationPolicy.set_pending(Reservation.find(params[:reservation_id]))
    redirect_to check_reservations_path
  end
end
