# -*- encoding : utf-8 -*-
class PlaceDecorator < Draper::Decorator
  delegate_all

  def status_icon
    return h.content_tag(:span, '', class: 'fa fa-lock pull-right occupied') if place.active_checkin
    return h.content_tag(:span, '', class: 'fa fa-unlock-alt pull-right free')
  end

  def not_nil?
    !object.nil?
  end

end
