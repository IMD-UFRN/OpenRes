# -*- encoding : utf-8 -*-
class Sector < ActiveRecord::Base

   validates_presence_of :name, :description

   has_many :users
   has_many :places
   has_many :object_resources

end
