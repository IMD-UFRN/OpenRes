# -*- encoding : utf-8 -*-
class ClassSuggestionWorker
  include Sidekiq::Worker

  test_v = [
    [ #primeira turma
      [2], #professores
      40,  #capacidade
      [["2456M12",	1]], #horario requerido e tipo da sala
      [["2456M34",	1]],
      [["2456M12",	2]],
      [["2456M34",	2]],
      [["24M34",	1], ["56M34",	2]]
    ],
    [ #segunda turma
      [1],#professores
      30, #capacidade
      [["2456M12",	1]],
      [["2456M34",	3]],
      [["2456M12",	2]],
      [["2456M34",	2]],
      [["24M34",	1], ["56M34",	2]]
    ]
  ]

  rooms = [
    [
      "A305",      #código
      1            #tipo
      40,          #capacidade
      "2456M1234", #horario disp manha
      "",          #horario disp tarde
      "24N12",     #horario disp noite
    ]
    [
      "A306",      #código
      2            #tipo
      40,          #capacidade
      "2456M1234", #horario disp manha
      "",          #horario disp tarde
      "24N12",     #horario disp noite
    ]
    [
      "A307",      #código
      3            #tipo
      40,          #capacidade
      "2456M1234", #horario disp manha
      "",          #horario disp tarde
      "24N12",     #horario disp noite
    ]
  ]

  def perform(name, count)
    puts 'Doing hard work'
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

end
