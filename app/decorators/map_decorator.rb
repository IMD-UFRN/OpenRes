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
    @grouped_by_floor ||= object.group_by {|p| p.code[1]}
  end

  def get_places_count(floor)
    return 0 unless grouped_by_floor[floor.to_s]

    grouped_by_floor[floor.to_s].length
  end

end
