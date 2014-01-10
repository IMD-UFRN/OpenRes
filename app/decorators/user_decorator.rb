# -*- encoding : utf-8 -*-
class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def dashboard
    render "dashboard/#{object.role}"
  end

  def menu
    render "menu/#{object.role}"
  end
end
