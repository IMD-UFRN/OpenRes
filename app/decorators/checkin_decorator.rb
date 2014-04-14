class CheckinDecorator < Draper::Decorator
  delegate_all

  def begin_time
    object.begin_time.strftime("%H:%M")
  end

  def end_time
    return object.end_time.strftime("%H:%M") if object.end_time
    'N/A'
  end

  def reservation
    object.reservation.decorate
  end

end
