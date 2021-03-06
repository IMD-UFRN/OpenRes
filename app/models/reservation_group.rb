# -*- encoding : utf-8 -*-

class ReservationGroup < ActiveRecord::Base

  has_paper_trail on: [:update, :destroy]

  has_many :reservations

  scope :confirmed, lambda{
    ReservationGroup.where.not(confirmed_at: nil)
  }
  scope :not_confirmed, lambda{
    ReservationGroup.where(confirmed_at: nil)
  }

  scope :from_class, lambda{
    where(from_class: true)
  }

  scope :not_from_class, lambda{
    where(from_class: nil)
  }

  scope :from_user, lambda{ |user|
    ReservationGroup.where(user_id: user.id)
  }

  # scope :from_sector, lambda { |sector|
  #
  #   ReservationGroup.where()
  #
  #   reservations = []
  #
  #   ReservationGroup.all.each do |reservation|
  #
  #     if reservation.sectors_ids.include? sector.id
  #
  #       reservations << reservation
  #     end
  #   end
  #
  #   return reservations
  # }

  scope :from_sectors, lambda { |sector_ids|

    ReservationGroup.find(Reservation.where(place_id: PlaceSector.where(sector_id: sector_ids).pluck(:place_id)).pluck(:reservation_group_id))

    # Register.where(competition_id: Competition.where("..."))
    #
    # reservations = []
    #
    # ReservationGroup.all.each do |reservation|
    #
    #   if (reservation.sectors_ids - sector_ids).length < reservation.sectors_ids.length
    #
    #     reservations << reservation
    #   end
    # end
    #
    # return reservations
  }

  scope :from_place, lambda { |place|

    ReservationGroup.confirmed.joins(:reservations).where("reservations.place_id = ?", place.id).distinct

  }


  scope :from_future, lambda{
    ReservationGroup.joins(:reservations).group("reservation_groups.id").having("max(reservations.date) >= ?", DateTime.now.to_date)

  }

  scope :from_past, lambda{
    ReservationGroup.joins(:reservations).group("reservation_groups.id").having("max(reservations.date) < ?", DateTime.now.to_date)

  }

  scope :can_decide_over, lambda { |user|
    return ReservationGroup.none if user.nil? || user.role == "basic"
    return ReservationGroup.all if user.role == "admin"
    return ReservationGroup.from_sectors(user.sector_ids) # if user.role == 'secretary' or 'sector_admin'
  }


  def sectors_ids
    place.sector_ids
  end

  def responsible
    return reservations.first.responsible
  end

  def places
    reservations.map(&:place).uniq
  end

  def place_name
    reservations.first.place.name
  end

  def place
    reservations.first.place
  end

  def user
    reservations.first.user
  end

  def begin_date
    byebug if reservations == []

    reservations.order(:date).first.date
  end

  def end_date
    reservations.order(:date).last.date
  end

  def days
    my_days = []
    reservations.each do |r|
      my_days << r.date.wday
    end
    my_days.uniq
  end

  def status
    status =[]
    reservations.each do |r|
      status << r.status
    end

    status = status.uniq

    if status.length == 1
      if status[0] == "approved"
        return "approved"
      elsif status[0] =="pending"
        return "pending"
      elsif status[0] == "rejected"
        return "rejected"
      else
        return "canceled"
      end
    elsif status.include? "approved"
      return "partially approved"
    elsif status.include? "pending"
      return "partially pending"
    elsif status.include? "canceled"
      return "partially canceled"
    end

  end

  def can_be_decided_over?(ap_user)
    reservations.first.can_be_decided_over?(ap_user)
  end

  def has_conflicts?
    reservations.each do |r|
      return true if r.has_conflicts?
    end

    false
  end

  def past?
    return true if begin_date < DateTime.now.to_date
  end

  def reason
    reservations.first.reason
  end

  def date_interval
    begin_date..end_date
  end

  def created_by
    reservations.first.created_by
  end

  def self.filter(reservation_groups, params)

    begin_date = Date.new(2000,1,1)
    end_date = Date.new(3000,1,1)

    begin_date = Date.strptime(params[:begin_date], "%d/%m/%Y") - 1.day if not params[:begin_date] == ""
    end_date = Date.strptime(params[:end_date], "%d/%m/%Y") if not params[:end_date] == ""

    ReservationGroup.select do |r|
      r.date_interval.overlaps? begin_date..end_date
    end

  end
end
