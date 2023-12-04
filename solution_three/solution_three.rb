# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

def parse_input(input, partMap, symbolCoords)
  inputArray = input.split("\n")
  inputArray.each_with_index do |line, y|
    token = ""
    line.each_char.with_index { |char, x|
      if char != char.to_i.to_s && char != '.'
        symbolCoords.append([x,y])
      end
      if char != char.to_i.to_s && !token.empty?
        partMap.append({
                          part_number: token.to_i,
                          x_range: [x-token.length-1, x],
                          y_range: [y-1, y+1],
                          length: token.length
                       })
        token = ""
      else
        token = token + char unless char != char.to_i.to_s
      end
    }
    unless token.empty?
      partMap.append({
                       part_number: token.to_i,
                       x_range: [line.length-token.length-1, line.length],
                       y_range: [y-1, y+1],
                     })
      token = ""
    end

  end
end
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  partMap = []
  symbolCoords = []
  parse_input(input, partMap, symbolCoords)

  goodParts = []
  symbolCoords.each do |coord |
    tempGoodParts = []
    partMap.each { |part |
      if coord.first >= part[:x_range].first && coord.first <= part[:x_range].last && coord.last >= part[:y_range].first && coord.last <= part[:y_range].last
        tempGoodParts.append(part)
      end
    }
    tempGoodParts.each { |part|
      goodParts.append(part)
      partMap.delete(part)
    }
  end
  print goodParts.map { |part | part[:part_number].to_i}.sum
end


solve("solution_three/question_input" )