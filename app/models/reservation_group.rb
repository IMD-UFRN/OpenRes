# -*- encoding : utf-8 -*-

class ReservationGroup < ActiveRecord::Base

  has_paper_trail :meta => { :responsible  => :responsible,
                             :reason => :reason,
                             :status => :status
                      }


  has_many :reservations


  scope :confirmed, lambda{
    ReservationGroup.where.not(confirmed_at: nil)
  }

  scope :from_user, lambda{ |user|
    ReservationGroup.where(user_id: user.id)
  }

  scope :from_sector, lambda { |sector|

    reservations = []

    ReservationGroup.all.each do |reservation|

      if reservation.sectors_ids.include? sector.id

        reservations << reservation
      end
    end

    return reservations
  }

  scope :from_sectors, lambda { |sector_ids|

    reservations = []

    ReservationGroup.all.each do |reservation|

      if (reservation.sectors_ids - sector_ids).length < reservation.sectors_ids.length

        reservations << reservation
      end
    end

    return reservations
  }

  scope :from_place, lambda { |place|

    reservations = []

    ReservationGroup.all.each do |reservation|

      if reservation.place.id == place.id
        reservations << reservation
      end
    end

    return reservations
  }


  scope :from_future, lambda{
    reservations = []

    ReservationGroup.all.each do |reservation|

      if reservation.begin_date >= DateTime.now.to_date
        reservations << reservation
      end
    end

    return reservations
  }

  scope :from_past, lambda{
    reservations = []

    ReservationGroup.all.each do |reservation|

      if reservation.begin_date < DateTime.now.to_date
        reservations << reservation
      end
    end

    return reservations
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
