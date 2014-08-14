# -*- encoding : utf-8 -*-
class ReservationSearchDecorator < Draper::Decorator
  delegate_all

  def begin_date
    object.try(:[], :begin_date) || ""
  end

  def end_date
    object.try(:[], :end_date) || ""
  end

  def begin_time
    object.try(:[], :begin_time) || ""
  end

  def end_time
    object.try(:[], :end_time) || ""
  end
end
