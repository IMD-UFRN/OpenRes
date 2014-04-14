class Checkin < ActiveRecord::Base
  belongs_to :reservation

  scope :active, -> { where(end_time: nil) }
  scope :finished, -> { where.not(end_time: nil) }
  scope :from_today, lambda { where(date: Date.today)  }

  scope :from_place, lambda { |place|
    joins('LEFT JOIN reservations ON reservations.id = checkins.reservation_id')
    .select('checkins.*, reservations.place_id')
    .where(:'reservations.place_id' => place.id)
  }

  delegate :place, to: :reservation
end
