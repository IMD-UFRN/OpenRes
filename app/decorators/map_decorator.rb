# -*- encoding : utf-8 -*-
class MapDecorator < Draper::Decorator

  decorates :place

  delegate_all

  def color_hash
    hash ={"background" => "#696969"}

    object.each do |p|
      hash[p.code] = "#729ae3"
    end

    hash.to_json
  end

  def grouped_by_floor
    object.inspect
  end

end
