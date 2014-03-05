class ReservationGroup < ActiveRecord::Base
  has_many :reservations
end
