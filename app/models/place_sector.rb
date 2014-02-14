# -*- encoding : utf-8 -*-
class PlaceSector < ActiveRecord::Base
  belongs_to :place
  belongs_to :sector
end
