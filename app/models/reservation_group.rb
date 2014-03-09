class ReservationGroup < ActiveRecord::Base
  has_many :reservations

  def user
	   reservations.first.user
  end
end
