# -*- encoding : utf-8 -*-
class Reservation < ActiveRecord::Base

  before_create do |obj|
    obj.status = 'pending'
  end

  scope :from_sector, lambda { |sector|
    places = sector.places.map(&:id)
    return Reservation.where('place_id IN (?)', places)
  }

  scope :can_decide_over, lambda { |user|
    return Reservation.none if user.nil? || user.role == "basic"
    return Reservation.all if user.role == "admin"
    return Reservation.from_sector(user.sector) # if user.role == 'secretary' or 'sector_admin'
  }

  validates_presence_of :place_id, :user_id, :begin_time, :end_time

  belongs_to :user
  belongs_to :place

  delegate :sector, to: :place
end
