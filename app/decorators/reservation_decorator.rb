class ReservationDecorator < Draper::Decorator
  delegate_all

  #talvez internacionalizar isso?
  def status
    return 'Aprovada' if object.status == 'approved'
    return 'Rejeitada' if object.status == 'rejected'
    return 'Pendente' if object.status == 'pending'
  end

  def begin_time
    I18n.l object.begin_time, format: :short
  end

  def end_time
    I18n.l object.begin_time, format: :short
  end

  def user
    h.link_to(object.user.name, object.user)
  end

  def place
    h.link_to(object.place.name, object.place)
  end
end
