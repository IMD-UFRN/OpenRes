# -*- encoding : utf-8 -*-
class ReservationGroupApprovalController < ApplicationController
  def index
    if params[:filter_by] == "future"

      reservations = []

      ReservationGroup.can_decide_over(current_user).each do |reservation|
        reservations << reservation if reservation.begin_date >= DateTime.now.to_date
      end

      @reservation_groups = ReservationGroupDecorator.decorate_collection(reservations)

    elsif params[:filter_by] == "finished"

      reservations = []

      ReservationGroup.can_decide_over(current_user).each do |reservation|
        reservations << reservation if reservation.begin_date < DateTime.now.to_date
      end

      @reservation_groups = ReservationGroupDecorator.decorate_collection(reservations)
      
    else
      @reservation_groups = ReservationGroupDecorator.decorate_collection(ReservationGroup.can_decide_over(current_user))
    end

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
