# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, :to => :crud

    #can :manage, :all if Rails.env.development?

    #all permissions
    can :crud, Reservation, { user_id: user.id }
    can :read, :all
    can :get_reservations, Place
    can :new_select_reservation

    if user.role == "admin"
      can :manage, :all
    elsif user.role == "sector_admin"
      can :manage, Reservation do |reservation|
        unless reservation.place.nil?
          #reservation.sector_ids.include?(user.sector.id)
          reservation.can_be_decided_over?(user)
        end
      end

      can :manage, ReservationGroup do |reservation_group|
        unless reservation_group.place.nil?
          #reservation_group.sector_ids.include?(user.sector.id)
          (reservation_group.sector_ids - user.sector_ids).length < reservation_group.sector_ids.length
        end
      end


      can :manage , Place do |place|
        unless place.sector_ids.nil?
          #place.sector_ids.include?(user.sector.id)
          (place.sector_ids - user.sector_ids).length < place.sector_ids.length
        end
      end

      can :read, User

    elsif user.role == "secretary"
      can :manage, Reservation do |reservation|
        unless reservation.place.nil?
          #reservation.sector_ids.include?(user.sector.id)
          reservation.can_be_decided_over?(user)
          #(reservation.sector_ids - user.sector_ids).length < reservation.sector_ids.length
        end
      end

      can :manage, ReservationGroup do |reservation_group|
        unless reservation_group.place.nil?
          #reservation_group.sector_ids.include?(user.sector.id)
          (reservation_group.sector_ids - user.sector_ids).length < reservation_group.sector_ids.length
        end
      end

      can :read, User

    elsif user.role == "basic"

      can :select_reservation, Reservation
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
