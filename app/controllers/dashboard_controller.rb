# -*- encoding : utf-8 -*-
class DashboardController < ApplicationController
  def dashboard
    @user = UserDecorator.decorate(current_user)
    @reservations = ReservationDecorator.decorate_collection(current_user.reservations)
    @open_reservations = ReservationDecorator.decorate_collection(Reservation.open_from_user(@user))
    @approved_reservations = ReservationDecorator.decorate_collection(Reservation.approved_from_user(@user))
    @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_from_user(@user))
  end
end
