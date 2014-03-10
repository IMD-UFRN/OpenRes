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

  def self.suspend_all(reservation_group, justification)

    reservation_group.reservations.each do |reservation|
      reservation.status = "pending"

      ActiveRecord::Base.transaction do
        justification.save
        reservation.save
      end


    end

    ReservationApprovalMailer.suspended_group_mail(reservation_group, justification).deliver
  end

  def self.reject_all(reservation_group, justification)

    reservation_group.reservations.each do |reservation|
      reservation.status = "rejected"

      ActiveRecord::Base.transaction do
        justification.save
        reservation.save
      end

    end

    ReservationApprovalMailer.rejected_group_mail(reservation_group, justification).deliver

  end

  def self.approve_all(reservation_group)

    conflicts =[]
    reservation_group.reservations.each do |reservation|

      conflicts << Reservation.conflicting(reservation)

      if conflicts.empty?
        reservation.status = "approved"

        reservation.save
      end

    end

    ReservationApprovalMailer.approved_group_mail(reservation_group).deliver

    return conflicts

  end
end
