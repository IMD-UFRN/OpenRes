# -*- encoding : utf-8 -*-
class PlaceDecorator < Draper::Decorator
  include Draper::LazyHelpers
  
  delegate_all

  def status_icon
    return h.content_tag(:span, '', class: 'fa fa-lock pull-right occupied') if place.active_checkin
    return h.content_tag(:span, '', class: 'fa fa-unlock-alt pull-right free')
  end

  def not_nil?
    !object.nil?
  end

  def sectors
    object.sectors.map do |sector|
      link_to(sector.name, sector)
    end.join(", ").html_safe
  end

end
