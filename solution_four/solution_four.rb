# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

def parse_input(input)
  input_array = input.split("\n")
  input_array.map! do |line|
    winning_current = line.split(":")[1].split("|")
    winning_numbers = winning_current.first.split(" ")
    current_numbers = winning_current.last.split(" ")
    current_numbers.intersection(winning_numbers)
  end
end
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  successful_numbers = parse_input(input)
  result = successful_numbers.sum { |set|
    set.empty? ? 0 : 2 ** (set.length-1)
  }
  print(result)
end


solve("solution_four/question_input" )