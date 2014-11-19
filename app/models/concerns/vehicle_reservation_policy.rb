# -*- encoding : utf-8 -*-
class VehicleReservationPolicy

  def self.approve(reservation, opts={})

    conflicts = VehicleReservation.approved.conflicting(reservation)

    if conflicts.empty?
      reservation.status = "approved"

      unless opts[:silent]
        VehicleReservationApprovalMailer.approved_mail(reservation).deliver

      end

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

    unless opts[:silent]
      VehicleReservationApprovalMailer.suspended_mail(reservation, justification).deliver

    end

  end

  def self.reject(reservation, justification, opts={})
    reservation.status = "rejected"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end

    unless opts[:silent]
      VehicleReservationApprovalMailer.rejected_mail(reservation, justification).deliver

    end

  end

end
