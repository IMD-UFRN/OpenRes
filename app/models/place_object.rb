# -*- encoding : utf-8 -*-
class PlaceObject < ActiveRecord::Base
  belongs_to :place 
  belongs_to :object_resource
end
