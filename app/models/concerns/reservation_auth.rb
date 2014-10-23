# -*- encoding : utf-8 -*-
class ReservationAuth

  def self.can_approve?(user, reservation)
    reservation.status != 'approved' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user)
  end

  def self.can_approve_group?(user, reservation_group)
    reservation_group.status != 'approved' && reservation_group.status != 'canceled' && reservation_group.can_be_decided_over?(user) && reservation_group.confirmed_at
  end

  def self.can_approve_list?(user, list)

    list.each do |reservation|
      return true if can_approve?(user, reservation)
    end

    false
  end

  def self.can_suspend?(user, reservation)
    reservation.status != 'pending' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user)
  end

  def self.can_suspend_group?(user, reservation_group)
    reservation_group.status != 'pending' && reservation_group.status != 'canceled' && reservation_group.can_be_decided_over?(user) && reservation_group.confirmed_at
  end

  def self.can_suspend_list?(user, list)

    list.each do |reservation|
      return true if can_suspend?(user, reservation)
    end

    false
  end

  def self.can_reject?(user, reservation)
    reservation.status != 'rejected' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user)
  end

  def self.can_reject_group?(user, reservation_group)
    reservation_group.status != 'rejected' && reservation_group.status != 'canceled' && reservation_group.can_be_decided_over?(user) && reservation_group.confirmed_at
  end

  def self.can_reject_list?(user, list)

    list.each do |reservation|
      return true if can_reject?(user, reservation)
    end

    false
  end

  def self.can_edit?(user, reservation)
    reservation.user == user && !reservation.past? && reservation.status != "rejected" && reservation.status != 'canceled'
  end

  def self.can_edit_group?(user, reservation_group)
    reservation_group.user == user && !reservation_group.past? && reservation_group.status != "rejected" && reservation_group.status != 'canceled'
  end

  def self.can_cancel?(user, reservation)
    reservation.status != 'canceled' && reservation.status != "rejected" && (reservation.user == user || reservation.created_by == user)  && !reservation.past? && (reservation.reservation_group ? !reservation.reservation_group.confirmed_at.nil? : true)
  end

  def self.can_cancel_group?(user, reservation_group)
    reservation_group.status != 'canceled' && reservation_group.status != "rejected" && (reservation_group.user == user || reservation_group.created_by == user)  && !reservation_group.past?
  end

  def self.can_cancel_list?(user, list)

    list.each do |reservation|
      return true if can_cancel?(user, reservation)
    end

    false
  end

  def self.can_delete?(user, reservation)

    result = reservation.status != 'canceled' && reservation.status != "rejected" && (reservation.user == user || reservation.created_by == user) && !reservation.past?

    if (reservation.reservation_group)
       result = result && reservation.reservation_group.confirmed_at.nil?
    end

    result
  end


  def self.can_delete_list?(user, list)

    list.each do |reservation|
      return true if can_delete?(user, reservation)
    end

    false
  end

  def self.can_create_class?(user)
    user.role == "admin"
  end

end
