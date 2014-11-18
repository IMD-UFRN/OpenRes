# -*- encoding : utf-8 -*-
class VehicleReservationPolicy

  def self.approve(reservation, opts={})

    conflicts = VehicleReservation.approved.conflicting(reservation)

    if conflicts.empty?
      reservation.status = "approved"

      reservation.save
    end

    return conflicts
  end

  def self.suspend(reservation, justification, opts={})

    reservation.status = "pending"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end

  end

  def self.reject(reservation, justification, opts={})
    reservation.status = "rejected"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end

  end

end
