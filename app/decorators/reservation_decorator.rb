# -*- encoding : utf-8 -*-
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
    object.begin_time.strftime("%H:%M")
  end

  def end_time
    object.end_time.strftime("%H:%M")
  end

  def date
    object.date.strftime("%d/%m/%Y")  
  end

  def user
    link_to(object.user.name, object.user)
  end

  def place
    link_to(object.place.name, object.place)
  end

  def top_rect
    @top_rect ||= (object.begin_time.hour * 60 + object.begin_time.min) * 0.5
  end  

  def rect_height
    ((object.end_time.hour * 60 + object.end_time.min) * 0.5) - top_rect
  end

  def random_color
    "%06x" % (rand * 0xffffff)
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
      link_to 'Rejeitar', justify_reject_path(reservation),
       {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window'}
    end
  end

  def suspend_link
    return if object.status == 'pending'

    content_tag :td do
      link_to 'Suspender', justify_suspend_path(reservation),
       {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window'}
    end
  end

end
