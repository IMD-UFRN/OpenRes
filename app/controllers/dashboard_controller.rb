# -*- encoding : utf-8 -*-
class DashboardController < ApplicationController
  def dashboard
    @user = UserDecorator.decorate(current_user)

    if @user.role != "basic"
      redirect_to check_reservations_path
    else
      redirect_to reservations_path
    end


  end
end
