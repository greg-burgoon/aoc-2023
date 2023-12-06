# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

def parse_input(input)
  input_array = input.split("\n\n")
  almanac = {
    seeds: [],
    maps: []
  }
  input_array.each_with_index do |map_data, index|
    if index == 0
      almanac[:seeds] = map_data.split(":").last.split(" ").map!{|element| element.to_i }
    else
      maps = map_data.split(":\n").last.split("\n")
      maps.map! { | source_destination |
        source_destination_array = source_destination.split(" ")
        {
          source: source_destination_array[1].to_i,
          destination: source_destination_array[0].to_i,
          length: source_destination_array[2].to_i
        }
      }.sort_by! { | element |  element[:source] }
      almanac[:maps].append(maps)
    end
  end
  almanac
end
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  almanac = parse_input(input)
  seeds = almanac[:seeds]
  almanac[:maps].each do |source_destination_array|
    seeds.map! { | seed |
      destination = seed
      source_destination_array.each { | source_destination |
        if (seed >= source_destination[:source] && seed <= source_destination[:source] + source_destination[:length]-1)
          destination = seed + (source_destination[:destination] - source_destination[:source])
        end
      }
      destination
    }
  end
  print(seeds.min)
end


solve("solution_five/question_input" )