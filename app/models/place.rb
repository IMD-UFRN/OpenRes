class Place < ActiveRecord::Base
  belongs_to :sector
  belongs_to :room_type
end
