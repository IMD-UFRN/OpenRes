class ReservationApprovalController < ApplicationController
  def index
    #@reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user))

    @open_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).open_for_sector(current_user.object.sector))
    @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).approved_for_sector(current_user.object.sector))
    @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user).rejected_for_sector(current_user.object.sector))
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
