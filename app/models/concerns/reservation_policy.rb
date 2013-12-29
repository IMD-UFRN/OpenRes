class ReservationPolicy

  def self.suspend(reservation)
    reservation.status = "pending"
    #send email
    reservation.save
  end

  def self.reject(reservation)
    reservation.status = "rejected"
    #send email
    reservation.save
  end

  def self.approve(reservation)
    conflicts = Reservation.where("place_id = ? and status = ? and begin_time <= ? and end_time >= ? and id <> ?",
     reservation.place.id, 'approved', reservation.end_time, reservation.begin_time, reservation.id)

    if conflicts.empty?
      reservation.status = "approved"
      #send email
      reservation.save
    end

    return conflicts
  end
end