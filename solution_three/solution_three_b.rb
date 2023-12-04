# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

def parse_input(input, part_map, symbol_coords)
  input_array = input.split("\n")
  input_array.each_with_index do |line, y|
    token = ""
    line.each_char.with_index { |char, x|
      if char != char.to_i.to_s && char != '.'
        symbol_coords.append({
                              symbol: char,
                              coords: [x,y]
                            })
      end
      if char != char.to_i.to_s && !token.empty?
        part_map.append({
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
      part_map.append({
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
  part_map = []
  symbol_coords = []
  parse_input(input, part_map, symbol_coords)

  gear_ratios = []
  symbol_coords.select { |symbol | symbol[:symbol] == '*'}.each do |sym |
    gear_neighbours = []
    part_map.each { |part |
      if sym[:coords].first >= part[:x_range].first && sym[:coords].first <= part[:x_range].last && sym[:coords].last >= part[:y_range].first && sym[:coords].last <= part[:y_range].last
        gear_neighbours.append(part[:part_number].to_i)
      end
    }
    gear_ratios.append(gear_neighbours.inject(:*)) unless gear_neighbours.length != 2
  end
  print gear_ratios.map { |part | part.to_i}.sum
end


solve("solution_three/question_input" )