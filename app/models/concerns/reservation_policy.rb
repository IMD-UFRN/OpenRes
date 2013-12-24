class ReservationPolicy

  def self.set_pending(reservation)
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
    conflicts = Reservation.where("place_id = ? and begin_time <= ? and end_time >= ?",
     reservation.id, reservation.begin_time, reservation.end_time)

    if conflicts.empty?
      reservation.status = "approved"
      reservation.save
    end

    return conflicts
  end
end