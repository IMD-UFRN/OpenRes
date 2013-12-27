# -*- encoding : utf-8 -*-
class DashboardController < ApplicationController
  def dashboard
    @user = UserDecorator.decorate(current_user)
  end
end
