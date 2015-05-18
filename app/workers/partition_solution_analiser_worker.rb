class PartitionSolutionAnaliserWorker
  include Sidekiq::Worker

  @@test_v = []

  @@rooms = [
    [ #tipo 0
      { #sala
        code: "A305",
        capacity: 40,
        hours: "23456M1234 24N12"
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


  def debug(str)
    puts "\n\n\n"
    puts str
    puts "\n\n\n"
  end


  def conflicting?(solution)

    slots = {}

    debug(solution)

    solution.each_with_index do |hour, index|

      hour["room"].each do |room|

        days, hours = room["hours"].split(/[MTN]/)
        shift = room["hours"].scan(/[MTN]/)[0]

        days.chars.each do |d|

          hours.chars.each do |h|

            return true if (slots[room["code"]]["#{shift}"]["#{d}"]["#{h}"] rescue false)

            slots[room["code"]] ||= {}
            slots[room["code"]]["#{shift}"] ||= {}
            slots[room["code"]]["#{shift}"]["#{d}"] ||= {}
            slots[room["code"]]["#{shift}"]["#{d}"]["#{h}"] ||= {}

            @@test_v[index]["teachers"].each do |teacher|
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

  def perform(preferences, possible_rooms, partition)
    @@test_v = possible_rooms

    all =  Enumerator.new do |y|

      v = [partition].tap { |x| 1.upto(preferences.length-1) { x << 0 } }


      loop do
        y.yield(v)

        i = -1
        v[i] += 1

        while v[i] && v[i] >= preferences[i].length

          v[i] = 0
          i -= 1

          v[i] += 1 if v[i]

        end

        break if -i >= preferences.length

      end


    end

    result = []

    all.each do |solution|

      aux = [].tap { |x| solution.each_with_index {|i, s| x << preferences[s][i] } }

      c = conflicting?(aux)

      puts aux.inspect unless c

      result << aux unless c

      $redis.set('processed', $redis.get('processed').to_i + 1)

    end

    result
  end

end
