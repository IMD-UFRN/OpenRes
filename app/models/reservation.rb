# -*- encoding : utf-8 -*-
class Reservation < ActiveRecord::Base

  validates_presence_of :place_id, :user_id, :date, :begin_time, :end_time, :reason

  validates :status, inclusion: { in: %w(pending approved rejected canceled) }

  belongs_to :user
  belongs_to :place
  belongs_to :reservation_group

  has_one :justification

  has_many :checkins

  delegate :sectors, to: :place

  before_create do |obj|

    if obj.begin_time > obj.end_time
      obj.errors.add(:horário, "de fim especificado não pode ser anterior que o horário de início")
      return false
    end

    obj.status = 'pending'

  end

  def time_interval
    begin_time..end_time
  end

  scope :from_sector, lambda { |sector|
    places = sector.places.map(&:id)
    return Reservation.where('place_id IN (?)', places)
  }

  scope :from_sectors, lambda { |sectors| #<-------- AQUI

    places = []
    sectors.each do |sector|
      places += sector.places.map(&:id)
    end

    return Reservation.where('place_id IN (?)', places)
  }

  scope :not_grouped, lambda{
    Reservation.where(reservation_group_id: nil)
  }

  scope :can_decide_over, lambda { |user|
    return Reservation.none if user.nil? || user.role == "basic"
    return Reservation.all if user.role == "admin"
    return Reservation.from_sectors(user.sectors) # if user.role == 'secretary' or 'sector_admin'  #<-------- AQUI
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
    reservations = Reservation.where("place_id = ? and date = ? and id <> ? and status <> ?",
     reservation.place_id, reservation.date, reservation.id, "rejected")
    return reservations.select { |r| r.time_interval.overlaps? reservation.time_interval }
  }

  scope :undone, lambda {
    result = []

    Reservation.each do |r|
      unless r.done?
        result << r
      end
    end

    return result
  }


  def has_conflicts?
    return !Reservation.conflicting(self).empty?
  end

  def sector_ids
    place.sector_ids
  end

  def can_be_decided_over?(ap_user)
    return true if ap_user.role == "admin"
    return false if (ap_user.role == "basic" || ap_user.role == "receptionist" || ! ( (sector_ids - ap_user.sector_ids).length <  sector_ids.length))
    return true
  end

  def done?
    !Checkin.finished.where(reservation_id: self.id).empty?
  end

  def sectors_names
    names = ""
    self.sectors.each do |sector|
      names+=sector.name
    end
    names
  end

  def past?

    return true if date <= Date.today

    h= end_time.hour
    m= end_time.min
    s= end_time.sec

    return true if h < Time.now.hour and m < Time.now.min and s < Time.now.sec

  end

end
