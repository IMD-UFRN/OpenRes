class RoomType < ActiveRecord::Base
   validates_presence_of :name, :description

   has_many :places
end