# -*- encoding : utf-8 -*-
class ClassesSuggestionsController < ApplicationController
  def index
  end

  def results
    @classes = JSON.parse($redis.get("classes"))
    @rooms = {JSON.parse($redis.get("rooms"))}
    @rooms[:room_allocations] = {}.tap do |room_allocations|
      @rooms.each do |room|
        room = room.first
        room_allocations[room["code"]] = room["hours"].split(/[MTN]/).inject(1) { |sum, current| sum * current.length }
      end
    end

    @possibilities = $redis.keys("result-*").map do |x|
      db_result = JSON.parse($redis.get(x))
      result = {
        preference_coefficient: 1 + db_result.inject(0) { |sum, current| sum + current["preference"].to_i } / db_result.length.to_f ,
        result: db_result,
        room_allocation_coefficient: {}
      }

      db_result.each do |suggestion|
        suggestion["room"].each do |room|
          result[:room_allocation_coefficient][room["code"]] ||= {}
          result[:room_allocation_coefficient][room["code"]]["total_hours"] ||= 0
          result[:room_allocation_coefficient][room["code"]]["total_hours"] += room["hours"].split(/[MTN]/).inject(1) { |sum, current| sum * current.length }
        end
      end
      result
    end.sort_by do |x|
      x[:preference_coefficient]
    end

  end

end
