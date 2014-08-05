# -*- encoding : utf-8 -*-
class ReservationPolicy

  def self.suspend(reservation, justification, opts={})
    reservation.status = "pending"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end
    unless opts[:silent]
      ReservationApprovalMailer.suspended_mail(reservation, justification).deliver
    end
  end

  def self.reject(reservation, justification, opts={})
    reservation.status = "rejected"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end
    unless opts[:silent]
      ReservationApprovalMailer.rejected_mail(reservation, justification).deliver
    end
  end

  def self.approve(reservation, opts={})
    conflicts = Reservation.approved.conflicting(reservation)

    if conflicts.empty?
      reservation.status = "approved"

      unless opts[:silent]
        ReservationApprovalMailer.approved_mail(reservation).deliver
      end

      reservation.save
    end

    return conflicts
  end

  def self.cancel(reservation, opts={})
    reservation.status = "canceled"
    reservation.save

    unless opts[:silent]
      NotifyUserMailer.send_canceled_mail(reservation)
    end

  end

  def self.suspend_all(reservation_group, justification)

    reservation_group.reservations.each do |reservation|
      ReservationPolicy.suspend(reservation, justification, {silent: true})
    end

    ReservationApprovalMailer.suspended_group_mail(reservation_group, justification).deliver
  end

  def self.reject_all(reservation_group, justification)

    reservation_group.reservations.each do |reservation|
      ReservationPolicy.reject(reservation, justification, {silent: true})
    end

    ReservationApprovalMailer.rejected_group_mail(reservation_group, justification).deliver

  end

  def self.approve_all(reservation_group)

    conflicts = []

    reservation_group.reservations.each do |reservation|
      ReservationPolicy.approve(reservation, {silent: true})
    end

    ReservationApprovalMailer.approved_group_mail(reservation_group).deliver

    return conflicts

  end

  def self.cancel_all(reservation_group, opts={})

    reservation_group.reservations.each do |reservation|
      ReservationPolicy.cancel(reservation, {silent: true})
    end

    NotifyUserMailer.send_canceled_group_mail(reservation_group).deliver
  end

end
