# -*- encoding : utf-8 -*-
class Reservation < ActiveRecord::Base

  before_create do |obj|
    obj.status = 'pending'
  end

  def time_interval
    begin_time..end_time
  end

  scope :from_sector, lambda { |sector|
    places = sector.places.map(&:id)
    return Reservation.where('place_id IN (?)', places)
  }

  scope :not_grouped, lambda{
    Reservation.where(reservation_group_id: nil)
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
    reservations = Reservation.where("place_id = ? and date = ? and id <> ?",
     reservation.place_id, reservation.date, reservation.id)
    return reservations.select { |r| r.time_interval.overlaps? reservation.time_interval }
  }

  validates_presence_of :place_id, :user_id, :date, :begin_time, :end_time, :reason

  belongs_to :user
  belongs_to :place
  belongs_to :reservation_group

  has_one :justification

  delegate :sectors, to: :place

  def has_conflicts?
    if not Reservation.conflicting(self).empty?
      return true
    else
      return false
    end
  end

  def sector_ids
    place.sector_ids
  end

  def can_be_decided_over?(ap_user)
    return true if ap_user.role == "admin"
    return false if (ap_user.role == "basic" || !sector_ids.include?(ap_user.sector.id))
    return true
  end

end
