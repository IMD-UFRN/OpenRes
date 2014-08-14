# -*- encoding : utf-8 -*-
class ReservationGroupApprovalController < ApplicationController
  def index
    if params[:filter_by] == "future"

      reservation_groups = []

      ReservationGroup.can_decide_over(current_user).each do |reservation|
        reservations << reservation if reservation.begin_date >= DateTime.now.to_date
      end

    elsif params[:filter_by] == "finished"

      reservation_groups = []

      ReservationGroup.can_decide_over(current_user).each do |reservation|
        reservations << reservation if reservation.begin_date < DateTime.now.to_date
      end

    else
      reservation_groups = ReservationGroup.can_decide_over(current_user)

      if params[:reservation_search]
        reservation_groups = ReservationGroup.filter(reservation_groups, params[:reservation_search])
      end
    end
    @reservation_groups = ReservationGroupDecorator.decorate_collection(reservation_groups)

    @params = ReservationSearchDecorator.decorate(params[:reservation_search])

  end

  def approve
    ReservationPolicy.approve_all(ReservationGroup.find(params[:reservation_group_id]))
    redirect_to check_group_reservations_path
  end

  def reject
    @justification = Justification.new(justification_params)

    ReservationPolicy.reject_all(ReservationGroup.find(params[:reservation_group_id]), @justification)
    redirect_to check_group_reservations_path
  end

  def suspend
    @justification = Justification.new(justification_params)

    ReservationPolicy.suspend_all(ReservationGroup.find(params[:reservation_group_id]), @justification)
    redirect_to check_group_reservations_path
  end

  def cancel
    ReservationPolicy.cancel_all(ReservationGroup.find(params[:reservation_group_id]))
    redirect_to reservation_groups_path(filter_by: "future"), notice: "Reserva cancelada com sucesso."
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
      merge(user_id: current_user.id, reservation_group_id: params[:reservation_group_id])
  end
end
