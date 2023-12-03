# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  inputArray = input.split("\n")
  inputArray.map! {
    |line|
    first = nil
    last = nil
    line.each_char {
      |c|
      integer = c.to_i
      if integer.to_s == c && first == nil
        first = integer
      end
      last = integer unless integer.to_s != c
    }
    (first.to_s+last.to_s).to_i
  }
  print(inputArray.sum)
end


solve("solution_two/question_input")