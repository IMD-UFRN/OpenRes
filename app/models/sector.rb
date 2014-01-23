# -*- encoding : utf-8 -*-
class Sector < ActiveRecord::Base

  validates_presence_of :name, :description

  has_many :users

  has_many :place_sectors
  has_many :places, through: :place_sectors
  
  has_many :object_resources

end
