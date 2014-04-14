# -*- encoding : utf-8 -*-
class DashboardController < ApplicationController
  def dashboard
    @user = UserDecorator.decorate(current_user)

    if @user.role == "basic"
      redirect_to reservations_path
    elsif @user.role == "receptionist"
      redirect_to reservations_path
    else
      redirect_to check_reservations_path
    end


  end
end
