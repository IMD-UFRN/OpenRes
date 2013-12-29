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

  def suspend
    ReservationPolicy.suspend(Reservation.find(params[:reservation_id]))
    redirect_to check_reservations_path
  end

  def justify_status
    @reservation = Reservation.find(params[:reservation_id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def justify_params
    params.require(:justification).permit(:reason)
  end
end
