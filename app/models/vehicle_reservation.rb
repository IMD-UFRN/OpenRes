# -*- encoding : utf-8 -*-
class VehicleReservation < ActiveRecord::Base

  belongs_to :vehicle
  belongs_to :driver
  belongs_to :user
  has_one :vehicle_reservation_justification

  validates_presence_of :driver, :vehicle, :date, :begin_time, :end_time, :reason

  before_create do |obj|

    if obj.begin_time > obj.end_time
      obj.errors.add(:horário, "de fim especificado não pode ser anterior que o horário de início")
      return false
    end

    obj.status = 'pending'

  end

  scope :approved, lambda{
    return VehicleReservation.where(status: 'approved')
  }

  scope :conflicting, lambda { |reservation|
    reservations = VehicleReservation.where("vehicle_id = ? and date = ? and id <> ? and status <> ? and status <> ?", reservation.vehicle_id, reservation.date, reservation.id, "rejected", "canceled")

    return reservations
      .select { |r| r.time_interval.overlaps? reservation.time_interval }
  }

  def has_conflicts?
    return !VehicleReservation.conflicting(self).empty?
  end

  scope :from_future, lambda{

    now_time = Time.new(2000, 1, 1, Time.now.hour, Time.now.min, 0, "+00:00")

    return VehicleReservation.where("date > ? OR ( date = ? AND end_time >= ? )", DateTime.now.to_date, DateTime.now.to_date, now_time)
  }

  scope :from_past, lambda{

    now_time = Time.new(2000, 1, 1, Time.now.hour, Time.now.min, 0, "+00:00")

    return VehicleReservation.where("date < ? OR ( date = ? AND end_time < ? )",  DateTime.now.to_date, DateTime.now.to_date, now_time)
  }

  def time_interval
    begin_time..end_time
  end

  def can_be_decided_over?(ap_user)
    return true if ap_user.role == "admin"

    false
  end

end
