# -*- encoding : utf-8 -*-
class ReservationPolicy

  def self.suspend(reservation, justification)
    reservation.status = "pending"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end

    ReservationApprovalMailer.suspended_mail(reservation, justification).deliver
  end

  def self.reject(reservation, justification)
    reservation.status = "rejected"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end
    
    ReservationApprovalMailer.rejected_mail(reservation, justification).deliver
  end

  def self.approve(reservation)
    conflicts = Reservation.conflicting(reservation)

    if conflicts.empty?
      reservation.status = "approved"
      
      ReservationApprovalMailer.approved_mail(reservation).deliver
      reservation.save
    end

    return conflicts
  end
end
