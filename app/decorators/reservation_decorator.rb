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

  def created_at
    object.created_at.strftime("%d/%m/%Y - %H:%M") 
  end

  def date
    object.date.strftime("%d/%m/%Y")  
  end

  def user
    link_to(object.user.name, object.user)
  end

  def place
    link_to(object.place.full_name, object.place)
  end

  def top_rect
    @top_rect ||= (object.begin_time.hour * 60 + object.begin_time.min) * 0.5
  end  

  def room_type
    link_to(object.place.room_type.name, object.place.room_type)
  end

  def rect_height
    ((object.end_time.hour * 60 + object.end_time.min) * 0.5) - top_rect
  end

  def random_color
    "%06x" % (rand * 0xffffff)
  end

  def approve_link
    return if object.status == 'approved'

    
      link_to 'Aprovar', reservation_approve_path(reservation), method: :post, class:"btn-small btn-success"

  end

  def reject_link
    return if object.status == 'rejected'

  
    link_to 'Rejeitar', justify_reject_path(reservation),
      {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window', class:"btn-small btn-danger"}
  
  end

  def suspend_link
    return if object.status == 'pending'

  
    link_to 'Suspender', justify_suspend_path(reservation),
     {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#modal-window',class:"btn-small btn-warning"}
  
  end

end
