class ReservationApprovalController < ApplicationController
  def index
    @reservations = ReservationDecorator.decorate_collection(Reservation.can_decide_over(current_user))
  end

  def approve
  end

  def reject
  end

  def set_pending
  end
end
