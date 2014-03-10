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

  scope :from_user, lambda{ |user|
    Reservation.where(user_id: user.id)
  }

  scope :approved, lambda{
    return Reservation.where(status: 'approved')
  }

  scope :pending, lambda{
    return Reservation.where(status: 'pending')
  }

  scope :rejected, lambda{
    return Reservation.where(status: 'rejected')
  }

  scope :from_future, lambda{
    return Reservation.where("date >= ?",  DateTime.now.to_date)
  }

  scope :from_past, lambda{
    return Reservation.where("date < ?",  DateTime.now.to_date)
  }

  scope :conflicting, lambda { |reservation|
    Reservation.where("place_id = ? and date = ? and status = ? and begin_time <= ? and end_time >= ? and id <> ?",
     reservation.place_id, reservation.date, 'approved', reservation.end_time, reservation.begin_time, reservation.id)
  }

  validates_presence_of :place_id, :user_id, :date, :begin_time, :end_time

  belongs_to :user
  belongs_to :place
  belongs_to :reservation_group

  has_one :justification

  delegate :sectors, to: :place

  def sector_ids
    place.sector_ids
  end
end
