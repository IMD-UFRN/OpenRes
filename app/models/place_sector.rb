class PlaceSector < ActiveRecord::Base
  belongs_to :place
  belongs_to :sector
end
