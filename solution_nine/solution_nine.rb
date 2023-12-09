# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

def parse_input(input)
  input_array = input.split("\n")
  input_array.map do | line |
    line.split(" ").map { |s| s.to_i }
  end
end
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  sequences = parse_input(input)
  sequences.map! do |sequence|
    stack = [sequence]
    while stack.last.sum != 0
      previous_line = stack.last
      nextline = []
      previous_line.each_cons(2) do | el1, el2|
        nextline.append((el2-el1))
      end
      stack.append(nextline)
    end

    stack.last.append(0)
    until stack.size == 1
      last_line = stack.pop
      new_value = last_line.last + stack.last.last
      stack.last.append(new_value)
    end
    stack.last.last
  end
  print(sequences.sum)
end


solve("solution_nine/question_input" )