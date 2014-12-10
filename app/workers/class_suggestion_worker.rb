# -*- encoding : utf-8 -*-
class ClassSuggestionWorker
  include Sidekiq::Worker

  def initialize
    @test_v = [
      { #primeira turma
        teachers:  ["Marcel"], #professores
        capacity: 40,  #capacidade
        suggestions: [    #lista de horários
          [{hours: "2456M12", room_type: 0}], #horario requerido e tipo da sala
          [{hours: "2456M34", room_type: 1}],
          [{hours: "2456M34", room_type: 2}],
          [{hours: "2456M34", room_type: 2}],
          [{hours: "24N12"  , room_type: 0}],
          [{hours: "24M34",	  room_type: 0},{hours: "56M34",	room_type: 0}]
        ]
      },

      { #segunda turma
        teachers:  ["Ivan"], #professores
        capacity: 20,  #capacidade
        suggestions: [    #lista de horários
          [{hours: "2456M12", room_type: 1}],
          [{hours: "2456M34", room_type: 0}],
          [{hours: "2456M12", room_type: 2}],
          [{hours: "2456M34", room_type: 2}],
          [{hours: "24M34"  , room_type: 1}, {hours: "56M34", room_type:	2}]
        ]
      },

      { #terceira turma
        teachers:  ["Marcel","Ivan"], #professores
        capacity: 20,  #capacidade
        suggestions: [    #lista de horários
          [{hours: "2456M12", room_type: 1}],
          [{hours: "2456M34", room_type: 0}],
          [{hours: "2456M12", room_type: 2}],
          [{hours: "2456M34", room_type: 2}],
          [{hours: "24N12"  , room_type: 1}]
        ]
      }
    ]

    @rooms = [
      [ #tipo 0
        { #sala
          code: "A305",
          capacity: 40,
          hours: "2456M1234 24N12"
        },#fim sala
        { #sala
          code: "A101",
          capacity: 20,
          hours: "2456M1234 56T34 2N1234"
        } #fim sala
      ], #fim tipo 0

      [ #tipo 1
        { #sala
          code: "A306",
          capacity: 40,
          hours: "2456M1234 456T12"
        } #fim sala
      ], #fim tipo 1

      [ #tipo 2
        { #sala
          code: "A307",
          capacity: 40,
          hours: "2456M1234 56T34 2N1234"
        } #fim sala
      ] #fim tipo 2
    ]
  end

  def perform(name, count)
    puts 'Doing hard work'
  end


  def test
    mass_slot_generator(expand_suggestion_list(@test_v, @rooms))
  end

  private

  def valid_room?(room, slot, capacity)

    return false if room[:capacity] < capacity

    days, hours = slot[:hours].split(/[MTN]/)
    shift = slot[:hours].scan(/[MTN]/)[0]

    r_days, r_hours = room[:hours].scan(/\d+[#{shift}]\d+/)[0].split(shift) rescue return false

    return (r_days.chars - days.chars).length == r_days.length - days.length && (r_hours.chars - hours.chars).length == r_hours.length - hours.length

  end

  def generate_all_suggestions(sugg, preference, rooms, capacity)

    aux = []

    sugg.each do |slot|
      aux << rooms[slot[:room_type]].map do |room|
        {code: room[:code], hours: slot[:hours]} if valid_room?(room, slot, capacity)
      end.compact
    end

    aux[0].product(*aux[1..-1]).map do |x|

      {preference: preference, room: x}

    end

  end

  def expand_suggestion_list(s_list, rooms)

    r = []

    s_list.each do |course|

      aux = []

      course[:suggestions].each_with_index do |sugg, ss_index|

        generate_all_suggestions(sugg, ss_index, rooms, course[:capacity]).each do |x|
          aux << x
        end

      end

      r << aux
    end

    r

  end

  def conflicting?(solution)

    slots = {}

    solution.each_with_index do |hour, index|

      hour[:room].each do |room|

        days, hours = room[:hours].split(/[MTN]/)
        shift = room[:hours].scan(/[MTN]/)[0]

        days.chars.each do |d|

          hours.chars.each do |h|

            return true if (slots[room[:code]]["#{shift}"]["#{d}"]["#{h}"] rescue false)

            slots[room[:code]] ||= {}
            slots[room[:code]]["#{shift}"] ||= {}
            slots[room[:code]]["#{shift}"]["#{d}"] ||= {}
            slots[room[:code]]["#{shift}"]["#{d}"]["#{h}"] ||= {}

            @test_v[index][:teachers].each do |teacher|
              return true if (slots[teacher]["#{shift}"]["#{d}"]["#{h}"] rescue false)

              slots[teacher] ||= {}
              slots[teacher]["#{shift}"] ||= {}
              slots[teacher]["#{shift}"]["#{d}"] ||= {}
              slots[teacher]["#{shift}"]["#{d}"]["#{h}"] ||= {}
            end

          end

        end

      end

    end

    false
  end

  def mass_slot_generator(preferences)

    all =  Enumerator.new do |y|

      v = [].tap { |x| 1.upto(preferences.length) { x << 0 } }

      loop do
        y.yield(v)

        i = -1
        v[i] += 1

        while v[i] && v[i] >= preferences[i].length

          v[i] = 0
          i -= 1

          v[i] += 1 if v[i]

        end

        break if -i > preferences.length

      end


    end

    # all = preferences[0].product(*preferences[1..-1])
    result = []

    all.each do |solution|
      aux = [].tap { |x| solution.each_with_index {|i, s| x << preferences[s][i] } }
      result << aux unless conflicting?(aux)

    end

    result
  end

end
