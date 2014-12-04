# -*- encoding : utf-8 -*-
class ClassSuggestionWorker
  include Sidekiq::Worker

  def initialize
    @test_v = [
      { #primeira turma
        teacher:  2, #professores
        capacity: 40,  #capacidade
        suggestions: [    #lista de horários
          [{hours: "2456M12", room_type: 0}], #horario requerido e tipo da sala
          [{hours: "2456M34", room_type: 1}],
          [{hours: "2456M12", room_type: 2}],
          [{hours: "2456M34", room_type: 2}],
          [{hours: "24M34",	  room_type: 0},{hours: "56M34",	room_type: 0}]
        ]
      },
      { #segunda turma
        teacher:  1, #professores
        capacity: 30,  #capacidade
        suggestions: [    #lista de horários
          [{hours: "2456M12", room_type: 1}],
          [{hours: "2456M34", room_type: 0}],
          [{hours: "2456M12", room_type: 2}],
          [{hours: "2456M34", room_type: 2}],
          [{hours: "24M34"  , room_type: 1}, {hours: "56M34", room_type:	2}]
        ]
      }
    ]

    @rooms = [
      [ #tipo 0
        { #sala
          code: "A305",
          capacity: 40,
          hours_m: "2456M1234",
          hours_a: "",
          hours_n: "24N12"
        },#fim sala
        { #sala
          code: "A101",
          capacity: 20,
          hours_m: "2456M1234",
          hours_a: "",
          hours_n: "24N1234"
        } #fim sala
      ], #fim tipo 0

      [ #tipo 1
        { #sala
          code: "A306",
          capacity: 40,
          hours_m: "2456M1234",
          hours_a: "",
          hours_n: "24N12"
        } #fim sala
      ], #fim tipo 1

      [ #tipo 2
        { #sala
          code: "A307",
          capacity: 40,
          hours_m: "2456M1234",
          hours_a: "35T12",
          hours_n: "24N12"
        } #fim sala
      ] #fim tipo 2
    ]
  end

  def perform(name, count)
    puts 'Doing hard work'
  end


  def test
    transform_suggestion_list(@test_v, @rooms)
  end

  private
  def generate_next_state(v)
    return false if v[0] == v.length

    i = 1

    v[-i] += 1

    while i <= v.length && v[-i] == v.length
      v[-i] = 0
      i += 1
    end

    return false if v[0] == v.length
    return v
  end

  def valid?(v)
  end

  def generate_all_suggestions(sugg, preference, rooms)

    aux = []

    sugg.each do |slot|
      aux << rooms[slot[:room_type]].map do |x|
        {code: x[:code], hours: slot[:hours]}
      end
    end

    aux[0].product(*aux[1..-1]).map do |x|

      {preference: preference, room: x}

    end

  end

  def transform_suggestion_list(s_list, rooms)

    r = []

    s_list.each do |course|

      aux = []

      course[:suggestions].each_with_index do |sugg, ss_index|

        generate_all_suggestions(sugg, ss_index, rooms).each do |x|
          aux << x
        end


      end

      r << aux
    end

    r

  end


end
