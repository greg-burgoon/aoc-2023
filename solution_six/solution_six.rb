# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

def parse_input(input)
  races = []
  input_array = input.split("\n")
  input_array.each { | line |
    split_line = line.split(":")
    symbol = split_line[0].to_s.downcase.to_sym
    split_line[1].split(" ").each_with_index { | race_data, index |
      if races[index]
        races[index][symbol] = race_data
      else
        races[index] = { symbol => race_data }
      end
    }
  }
  races
end
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  races = parse_input(input)
  races.map! do |race|
    max_time = race[:time].to_i
    record_distance = race[:distance].to_i
    new_record_count = 0
    (0..max_time).each { | time_instance |
      distance = time_instance*(max_time - time_instance)
      if (distance > record_distance)
        new_record_count = new_record_count + 1
      end
    }
    new_record_count
  end
  print(races.inject(:*))
end


solve("solution_six/question_input" )