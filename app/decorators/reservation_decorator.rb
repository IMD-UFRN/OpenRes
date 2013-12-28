class ReservationDecorator < Draper::Decorator
  include Draper::LazyHelpers

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
    I18n.l object.end_time, format: :short
  end

  def user
    link_to(object.user.name, object.user)
  end

  def place
    link_to(object.place.name, object.place)
  end

  def approve_link
    return if object.status == 'approved'

    content_tag :td do
      link_to 'Aprovar', reservation_approve_path(reservation), method: :post
    end
  end

  def reject_link
    return if object.status == 'rejected'

    content_tag :td do
      link_to 'Rejeitar', reservation_reject_path(reservation), method: :post
    end
  end

  def suspend_link
    return if object.status == 'pending'

    content_tag :td do
      link_to 'Suspender', reservation_set_pending_path(reservation), method: :post
    end
  end

end
