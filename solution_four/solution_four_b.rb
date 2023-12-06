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
  memo_map = Array.new(successful_numbers.length, 0)
  successful_numbers.each_with_index do |element, index|
    memo_map[index] = memo_map[index] + 1
    memo_map[index].times do
      element.each_with_index do |_, index_two|
        memo_map[index+index_two+1] = memo_map[index+index_two+1] + 1
      end
    end
  end

  print(memo_map.sum)
end


solve("solution_four/question_input" )