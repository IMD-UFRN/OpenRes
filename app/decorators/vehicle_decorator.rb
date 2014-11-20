# -*- encoding : utf-8 -*-
class VehicleDecorator < Draper::Decorator
  delegate_all

  def reservable

    return "Sim" if object.reservable
    "Não"
  end

end
