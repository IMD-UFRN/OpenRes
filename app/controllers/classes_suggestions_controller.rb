# -*- encoding : utf-8 -*-
class ClassesSuggestionsController < ApplicationController
  def index
  end

  def results
    @classes = JSON.parse($redis.get("classes"))

    room_allocations = Hash[
      JSON.parse($redis.get("rooms")).flatten.map do |current|
        [current["code"], current["hours"].split(/[MTN ]/).each_slice(2).inject(0) { |sum, c| sum + c[0].length * c[1].length }]
      end
    ]

    @possibilities = $redis.keys("result-*").map do |x|
      total_occupation = 0
      used_occupation = 0

      db_result = JSON.parse($redis.get(x))

      result = {
        preference_coefficient: 1 + db_result.inject(0) { |sum, current| sum + current["preference"].to_i } / db_result.length.to_f ,
        result: db_result,
        room_allocation_coefficient: {}
      }

      db_result.each do |suggestion|
        suggestion["room"].each do |room|
          used_hours = room["hours"].split(/[MTN]/).inject(1) { |sum, current| sum * current.length }

          result[:room_allocation_coefficient][room["code"]] ||= {}
          result[:room_allocation_coefficient][room["code"]]["used_hours"] ||= 0
          result[:room_allocation_coefficient][room["code"]]["used_hours"] += used_hours
        end
      end

      result[:room_allocation_coefficient].each do |room, stats|
        total_occupation += room_allocations[room]
        used_occupation += stats["used_hours"]

        stats["total_hours"] = room_allocations[room]
        stats["percentage"] = (stats["used_hours"] / room_allocations[room].to_f) * 100
      end

      result[:occupation_coefficient] = {}
      result[:occupation_coefficient][:total_occupation] = total_occupation
      result[:occupation_coefficient][:used_occupation] = used_occupation
      result[:occupation_coefficient][:percentage] = (100 * used_occupation / total_occupation.to_f)

      result
    end.sort_by do |x|
      x[:preference_coefficient]
    end

    @page = (params[:page].to_i - 1) * 5
    @page = params[:page].to_i - 1

    @page      = 0 if @page < 0
    @next_page = @page + 2

    @possibilities = @possibilities [@page * 5..@page * 5 + 4]
  end

end
