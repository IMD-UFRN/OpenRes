class ReservationGroupController < ApplicationController
  before_filter :authenticate_user!

  def new
    @reservation_group = ReservationGroup.new
  end

  def preview
  end

  def create
  end
end
