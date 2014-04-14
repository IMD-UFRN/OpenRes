# -*- encoding : utf-8 -*-
class Place < ActiveRecord::Base

  validates_presence_of :name, :code, :sector_ids

  has_many :place_sectors
  has_many :sectors, through: :place_sectors
  has_many :place_objects
  has_many :object_resources, through: :place_objects

  belongs_to :room_type
  has_many :reservations

  def self.grouped_by_type
    groups = []
    RoomType.all.each_with_index do |room_type, index|
      groups << [room_type.name, Place.where(room_type_id: room_type, reservable: true)]
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
end
