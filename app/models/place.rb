# -*- encoding : utf-8 -*-
class Place < ActiveRecord::Base

  validates_presence_of :name, :description, :sector_ids

  belongs_to :sector

  has_many :place_sectors
  has_many :sectors, through: :place_sectors

  belongs_to :room_type
  has_many :object_resources

  def self.grouped_by_type
    groups = []
    RoomType.all.each_with_index do |room_type, index|
      groups << [room_type.name, Place.where(room_type_id: room_type)]
    end
    return groups
  end
end
