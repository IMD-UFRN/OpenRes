# -*- encoding : utf-8 -*-
class Reservation < ActiveRecord::Base

  scope :can_decide_over, lambda { |user|
    return Reservation.all if user.role == "admin"

    return Reservation.none if user.role == "basic"
  }

  validates_presence_of :place_id, :user_id, :begin_time, :end_time

  belongs_to :user
  belongs_to :place

  delegate :sector, to: :place
end
