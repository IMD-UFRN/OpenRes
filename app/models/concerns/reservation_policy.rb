# -*- encoding : utf-8 -*-
class ReservationPolicy

  def self.suspend(current_user, reservation, justification, opts={})

    return unless reservation.can_be_decided_over? current_user

    reservation.status = "pending"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end
    unless opts[:silent]
      ReservationApprovalMailer.suspended_mail(reservation, justification).deliver

      reservation.place.class_monitors.each do |monitor|
        NotifyUserMailer.reservation_made_to_class_monitor(reservation, monitor).deliver
      end

    end
  end

  def self.reject(current_user, reservation, justification, opts={})
    reservation.status = "rejected"

    ActiveRecord::Base.transaction do
      justification.save
      reservation.save
    end
    unless opts[:silent]
      ReservationApprovalMailer.rejected_mail(reservation, justification).deliver

      reservation.place.class_monitors.each do |monitor|
        NotifyUserMailer.reservation_made_to_class_monitor(reservation, monitor).deliver
      end

    end
  end

  def self.approve(current_user, reservation, opts={})

    conflicts = Reservation.approved.conflicting(reservation)

    if conflicts.empty?
      reservation.status = "approved"

      unless opts[:silent]
        ReservationApprovalMailer.approved_mail(reservation).deliver

        reservation.place.class_monitors.each do |monitor|
          NotifyUserMailer.reservation_made_to_class_monitor(reservation, monitor).deliver
        end
      end

      reservation.save
    end

    return conflicts
  end

  def self.cancel(current_user, reservation, opts={})
    reservation.status = "canceled"
    reservation.save

    unless opts[:silent]
      User.select { |u| reservation.can_be_decided_over?(u) }.each do |user|
        NotifyUserMailer.reservation_canceled(reservation, user).deliver
      end

      reservation.place.class_monitors.each do |monitor|
        NotifyUserMailer.reservation_made_to_class_monitor(reservation, monitor).deliver
      end

    end

  end

  def self.delete(current_user, reservation, opts={})
    reservation.destroy
  end

  def self.suspend_all(current_user, reservation_group, justification)

    reservation_group.reservations.each do |reservation|
      ReservationPolicy.suspend(current_user, reservation, justification, {silent: true})
    end

    ReservationApprovalMailer.suspended_group_mail(reservation_group, justification).deliver

    reservation_group.place.class_monitors.each do |monitor|
      NotifyUserMailer.reservation_made_to_class_monitor(reservation_group, monitor).deliver
    end

  end

  def self.reject_all(current_user, reservation_group, justification)

    reservation_group.reservations.each do |reservation|
      ReservationPolicy.reject(current_user, reservation, justification, {silent: true})
    end

    ReservationApprovalMailer.rejected_group_mail(reservation_group, justification).deliver

    reservation_group.place.class_monitors.each do |monitor|
      NotifyUserMailer.reservation_made_to_class_monitor(reservation_group, monitor).deliver
    end
  end

  def self.approve_all(current_user, reservation_group)

    conflicts = []

    reservation_group.reservations.each do |reservation|
      ReservationPolicy.approve(current_user, reservation, {silent: true})
    end

    ReservationApprovalMailer.approved_group_mail(reservation_group).deliver

    reservation_group.place.class_monitors.each do |monitor|
      NotifyUserMailer.reservation_made_to_class_monitor(reservation_group, monitor).deliver
    end

    return conflicts

  end

  def self.cancel_all(current_user, reservation_group, opts={})

    reservation_group.reservations.each do |reservation|
      ReservationPolicy.cancel(current_user, reservation, {silent: true})
    end

    reservation_group.save

    User.select { |u| reservation_group.can_be_decided_over?(u) }.each do |user|
      NotifyUserMailer.reservation_group_canceled(reservation_group, user).deliver
    end

    reservation_group.place.class_monitors.each do |monitor|
      NotifyUserMailer.reservation_made_to_class_monitor(reservation_group, monitor).deliver
    end

  end

end
