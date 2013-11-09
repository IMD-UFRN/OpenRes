class ObjectResource < ActiveRecord::Base
  belongs_to :sector
  belongs_to :place
end
