# -*- encoding : utf-8 -*-
class ReservationApprovalController < ApplicationController

  before_action do
    authorize! :check_reservation, Reservation
  end

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

    @pending_list = ReservationListDecorator.initialize_decorator(@pending_sector_reservations, "approve", "reject")
    @approved_list = ReservationListDecorator.initialize_decorator(@approved_sector_reservations, "suspend", "reject")
    @rejected_list = ReservationListDecorator.initialize_decorator(@rejected_sector_reservations, "approve", "suspend")

    @params = ReservationSearchDecorator.decorate(params[:reservation_search])
  end

  def approve
    reservation = Reservation.find(params[:reservation_id])
    conflicts = ReservationPolicy.approve(current_user, reservation)

    if (conflicts.empty?)
      flash[:notice] = "Reserva aprovada com sucesso."
    else
      flash[:error] = "Esta reserva possui conflitos e não pode ser aprovada até que estejam resolvidos."
    end

    redirect_after_action(reservation)
  end

  def reject

    @justification = Justification.new(justification_params)

    reservation = Reservation.find(params[:reservation_id])

    ReservationPolicy.reject(current_user, reservation, @justification)

    flash[:notice] = "Reserva rejeitada com sucesso."

    redirect_after_action(reservation)

  end

  def suspend
    @justification = Justification.new(justification_params)

    reservation = Reservation.find(params[:reservation_id])

    ReservationPolicy.suspend(current_user, reservation, @justification)

    flash[:notice] = "Reserva suspensa com sucesso."

    redirect_after_action(reservation)
  end

  def cancel
    reservation = Reservation.find(params[:reservation_id])

    ReservationPolicy.cancel(current_user, reservation)

    flash[:notice] = "Reserva cancelada com sucesso."

    redirect_after_action(reservation)
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
