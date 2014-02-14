class PlaceObject < ActiveRecord::Base
  belongs_to :place 
  belongs_to :object_resource
end
