# -*- encoding : utf-8 -*-
class Place < ActiveRecord::Base

  validates_presence_of :name, :description, :sector_id

  belongs_to :sector
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
