class ObjectResource < ActiveRecord::Base

  validates_presence_of :name, :sector_id, :place_id

  belongs_to :sector
  belongs_to :place
end
