# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, :all

    can :manage, :all if user.role == "admin"

    can :check_reservation do
      user.role != "basic" && user.role != "receptionist"
    end

    can :approve, Reservation do |reservation|
      reservation.status != 'approved' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user)
    end

    can :approve, ReservationGroup do |reservation|
      reservation.status != 'approved' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user) && reservation.confirmed_at
    end

    can :suspend, Reservation do |reservation|
      reservation.status != 'pending' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user)
    end

    can :suspend, ReservationGroup do |reservation|
      reservation.status != 'pending' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user) && reservation.confirmed_at
    end

    can :reject, Reservation do |reservation|
      reservation.status != 'rejected' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user)
    end

    can :reject, ReservationGroup do |reservation|
      reservation.status != 'rejected' && reservation.status != 'canceled' && reservation.can_be_decided_over?(user) && reservation.confirmed_at
    end

    can :edit, Reservation do |reservation|
      reservation.user == user && !reservation.past? && reservation.status != "rejected" && reservation.status != 'canceled'
    end

    can :edit, ReservationGroup do |reservation|
      reservation.user == user && !reservation.past? && reservation.status != "rejected" && reservation.status != 'canceled'
    end

    can :cancel, Reservation do |reservation|
      reservation.status != 'canceled' && reservation.status != "rejected" && (reservation.user == user || reservation.created_by == user)  && !reservation.past?
    end

    can :cancel, ReservationGroup do |reservation|
      reservation.status != 'canceled' && reservation.status != "rejected" && (reservation.user == user || reservation.created_by == user)  && !reservation.past?
    end

    can :delete, Reservation do |reservation|
      reservation.status != 'canceled' && reservation.status != "rejected" && (reservation.user == user || reservation.created_by == user) && !reservation.past? && reservation.reservation_group && reservation.reservation_group.confirmed_at.nil?
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
