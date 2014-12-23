class ClassGenerator

  @@teachers= %w(Marcel Ivan José Maria)

  @@capacities = [20, 30, 40, 50]

  @@class_days = %w(24 35 246)

  @@class_slots = %w(12 34 56)

  @@shifts = %w(M T N)

  @@room_types = (0..2).to_a

  def self.get_percentage?(value)
    return value <= (0..99).to_a.sample
  end

  def self.comp_class(some_class)

    new_class_days = @@class_days - [some_class[:hours].split(/[MTN]/).first]

    {hours: new_class_days.sample + @@shifts.sample + @@class_slots.sample, room_type: @@room_types.sample}
  end

  def self.random_class
    {hours: @@class_days.sample + @@shifts.sample + @@class_slots.sample, room_type: @@room_types.sample}
  end

  def self.generate(class_count)
    v = []

    1.upto(class_count) do |i|

      this_class = {
        teachers: [@@teachers.sample],
        capacity: @@capacities.sample,
      }

      new_t = (@@teachers - [this_class[:teachers].first]).sample

      this_class[:teachers] << new_t if get_percentage?(85)

      classes= []

      1.upto(5) do

        classes << [random_class]

        puts classes.last.first.inspect

        new_class = comp_class(classes.last.first)

        classes.last << new_class if get_percentage?(90)

      end

      this_class[:suggestions] = classes

      v << this_class
    end

    v
  end

end
