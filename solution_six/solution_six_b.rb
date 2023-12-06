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

def find_first_record_break(max_time, record_distance, enumerable)
  new_record = nil
  enumerable.each { | time_instance |
      distance = time_instance *(max_time - time_instance)
    if (distance > record_distance)
      new_record = time_instance
      break;
    end
  }
  new_record
end

def solve(filename)
  input = Utilities.parse_file(filename: filename)
  races = parse_input(input)
  race = races.inject do |sum, el|
    sum[:time] = sum[:time] + el[:time]
    sum[:distance] = sum[:distance] + el[:distance]
    sum
  end
  max_time = race[:time].to_i
  record_distance = race[:distance].to_i
  new_record_start = find_first_record_break(max_time, record_distance, (0..max_time).to_a)
  new_record_end =  find_first_record_break(max_time, record_distance, max_time.downto(0).to_a)

  new_record_count = new_record_end - new_record_start + 1
  new_record_count
  print(new_record_count)
end


solve("solution_six/question_input" )