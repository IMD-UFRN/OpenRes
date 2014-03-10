# -*- encoding : utf-8 -*-
class ReservationGroup < ActiveRecord::Base
  has_many :reservations


  scope :from_user, lambda{ |user|
    ReservationGroup.where(user_id: user.id)
  }

  scope :from_sector, lambda { |sector|
    places = sector.places.map(&:id)
    return ReservationGroup.where('place_id IN (?)', places)
  }

  scope :can_decide_over, lambda { |user|
    return ReservationGroup.none if user.nil? || user.role == "basic"
    return ReservationGroup.all if user.role == "admin"
    return ReservationGroup.from_sector(user.sector) # if user.role == 'secretary' or 'sector_admin'
  }

  def place
    reservations.first.place
  end
  def begin_date
    reservations.first.date
  end

  def end_date
    reservations.last.date
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
      else
        return "rejected"
      end
    elsif status.include? "approved"
      return "partially approved"
    else status.include? "pending"
      return "partially pending"
    end

  end

end
