# -*- encoding : utf-8 -*-
class ReservationGroupApprovalController < ApplicationController
  def index
    if params[:filter_by] == "future"

      reservation_groups = []

      ReservationGroup.confirmed.can_decide_over(current_user).each do |reservation|
        reservation_groups << reservation if reservation.begin_date >= DateTime.now.to_date
      end

    elsif params[:filter_by] == "finished"

      reservation_groups = []

      ReservationGroup.confirmed.can_decide_over(current_user).each do |reservation|
        reservation_groups << reservation if reservation.begin_date < DateTime.now.to_date
      end

    else
      reservation_groups = ReservationGroup.confirmed.can_decide_over(current_user)

      if params[:reservation_search]
        reservation_groups = ReservationGroup.filter(reservation_groups, params[:reservation_search])
      end
    end
    @reservation_groups = ReservationGroupDecorator.decorate_collection(reservation_groups)

    @params = ReservationSearchDecorator.decorate(params[:reservation_search])

  end

  def approve

    reservation_group= ReservationGroup.find(params[:reservation_group_id])

    last_status =  reservation_group.status

    ReservationPolicy.approve_all(reservation_group)

    reservation_group.touch_with_version

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["status"] = [last_status, reservation_group.status] unless last_status == reservation_group.status

    pt.object_changes = cs.to_yaml

    pt.save

    redirect_to check_group_reservations_path(filter_by: "future"), notice: "Reserva aprovada com sucesso."
  end

  def reject
    @justification = Justification.new(justification_params)

    reservation_group= ReservationGroup.find(params[:reservation_group_id])

    last_status =  reservation_group.status

    ReservationPolicy.reject_all(reservation_group, @justification)

    reservation_group.touch_with_version

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["status"] = [last_status, reservation_group.status] unless last_status == reservation_group.status

    pt.object_changes = cs.to_yaml

    pt.save

    redirect_to check_group_reservations_path(filter_by: "future"), notice: "Reserva rejeitada com sucesso."
  end

  def suspend
    @justification = Justification.new(justification_params)

    reservation_group= ReservationGroup.find(params[:reservation_group_id])

    last_status =  reservation_group.status

    ReservationPolicy.suspend_all(reservation_group, @justification)

    reservation_group.touch_with_version

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["status"] = [last_status, reservation_group.status] unless last_status == reservation_group.status

    pt.object_changes = cs.to_yaml

    pt.save

    redirect_to check_group_reservations_path(filter_by: "future"), notice: "Reserva suspensa com sucesso."
  end

  def cancel
    reservation_group= ReservationGroup.find(params[:reservation_group_id])

    last_status =  reservation_group.status

    ReservationPolicy.cancel_all(reservation_group)

    reservation_group.touch_with_version

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["status"] = [last_status, reservation_group.status] unless last_status == reservation_group.status

    pt.object_changes = cs.to_yaml

    pt.save

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
