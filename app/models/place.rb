# -*- encoding : utf-8 -*-
class Place < ActiveRecord::Base

  validates_presence_of :name, :code, :sector_ids

  has_many :place_sectors
  has_many :sectors, through: :place_sectors
  has_many :place_objects
  has_many :object_resources, through: :place_objects

  belongs_to :room_type

  has_many :reservations
  has_many :class_monitors

  scope :reservable, where(reservable: true)

  def self.get_empty_places(date, begin_time, end_time)

    places = []
    reservations = Reservation.where(date: date, status: ["pending", "approved"]).reject { |r| r.reservation_group && !r.reservation_group.confirmed_at}

    Place.reservable.each do |place|

      x = true

      reservations.each do |r|

        x = x && !(r.time_interval.overlaps?(begin_time..end_time)) if r.place == place

      end

      places << place if x
    end

    places
  end

  def similar_places
    Place.reservable.where(room_type_id: room_type_id).where.not(id: id)
  end

  def self.grouped_by_type
    groups = []
    RoomType.all.each_with_index do |room_type, index|
      groups << [room_type.name, Place.reservable.where(room_type_id: room_type)]
    end
    return groups
  end

  def full_name
    code + " - " + name
  end

  def sectors_ids
    ids =[]
    sectors.each do |sector|
      ids << sector.id
    end

    ids
  end

  def active_checkin
    Checkin.active.from_place(self).last
  end

  def past_checkins
    Checkin.finished.from_place(self)
  end

  def can_be_decided_over?(ap_user)
    return true if ap_user.role == "admin"
    return false if (ap_user.role == "basic" || ap_user.role == "receptionist" || ! ( (sector_ids - ap_user.sector_ids).length <  sector_ids.length))
    return true
  end

  def can_be_decided_by
    users = []
    User.select { |u| self.can_be_decided_over?(u) }.each do |user|
      users << user
    end
    users
  end
end
