# -*- encoding : utf-8 -*-
class ObjectResource < ActiveRecord::Base

  validates_presence_of :name, :description

  has_many :place_objects
  has_many :places, through: :place_objects
end
