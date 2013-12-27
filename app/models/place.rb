# -*- encoding : utf-8 -*-
class Place < ActiveRecord::Base

  validates_presence_of :name, :description, :sector_id

  belongs_to :sector
  belongs_to :room_type
  has_many :object_resources
end
