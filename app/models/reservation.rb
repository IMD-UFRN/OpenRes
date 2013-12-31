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

  scope :open_from_user, lambda{ |user|
    return user.reservations.where(status: 'pending')
  } 

  scope :approved_from_user, lambda{ |user|
    return user.reservations.where(status: 'approved')
  }

  scope :rejected_from_user, lambda{ |user|
    return user.reservations.where(status: 'rejected')
  }

  scope :open_for_sector, lambda { |sector|
    return Reservation.from_sector(sector).where(status: 'pending')
  }
  
  scope :approved_for_sector, lambda { |sector|
    return Reservation.from_sector(sector).where(status: 'approved')
  }

  scope :rejected_for_sector, lambda { |sector|
    return Reservation.from_sector(sector).where(status: 'rejected')
  }

  scope :open_for_sector_to_come, lambda{ |sector|
    return Reservation.open_for_sector(sector).where("begin_time > ?",  DateTime.now)
  }

  scope :approved_for_sector_to_come, lambda{ |sector|
    return Reservation.approved_for_sector(sector).where("begin_time > ?",  DateTime.now)
  }

  scope :rejected_for_sector_to_come, lambda{ |sector|
    return Reservation.rejected_for_sector(sector).where("begin_time > ?",  DateTime.now)
  }

  scope :open_and_finished_for_sector, lambda{ |sector|
    return Reservation.open_for_sector(sector).where("begin_time < ?",  DateTime.now)
  }

  scope :approved_and_finished_for_sector, lambda{ |sector|
    return Reservation.approved_for_sector(sector).where("begin_time < ?",  DateTime.now)
  }

  scope :rejected_and_finished_for_sector, lambda{ |sector|
    return Reservation.rejected_for_sector(sector).where("begin_time < ?",  DateTime.now)
  }


  validates_presence_of :place_id, :user_id, :begin_time, :end_time

  belongs_to :user
  belongs_to :place

  has_one :justification

  delegate :sector, to: :place
end
