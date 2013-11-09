class Reservation < ActiveRecord::Base

  validates_presence_of :place_id, :user_id, :begin_time, :end_time

  belongs_to :user
  belongs_to :place
end
