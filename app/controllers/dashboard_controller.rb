# -*- encoding : utf-8 -*-
class DashboardController < ApplicationController
  def dashboard
    @user = UserDecorator.decorate(current_user)

    @open_reservations = ReservationDecorator.decorate_collection(Reservation.open_from_user_to_come(@user))
    @approved_reservations = ReservationDecorator.decorate_collection(Reservation.approved_from_user_to_come(@user))
    @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_from_user_to_come(@user))

    if @user.role == "secretary"

      @open_sector_reservations = ReservationDecorator.decorate_collection(Reservation.open_for_sector_to_come(@user.sector))
      @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.approved_for_sector_to_come(@user.sector))
      @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_for_sector_to_come(@user.sector))

    end
  end
end
