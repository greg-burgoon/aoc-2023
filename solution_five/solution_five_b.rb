# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'
require 'active_support/all'

def parse_input(input)
  input_array = input.split("\n\n")
  almanac = {
    seeds: [],
    maps: []
  }
  input_array.each_with_index do |map_data, index|
    if index == 0
      seed_ranges = map_data.split(":").last.split(" ").map!{ |element| element.to_i }
      seed_ranges.each_slice(2) { | range |
        almanac[:seeds].append((range.first..range.first+range.last-1))
      }
    else
      maps = map_data.split(":\n").last.split("\n")
      maps.map! { | source_destination |
        source_destination_array = source_destination.split(" ")
        {
          source_range: (source_destination_array[1].to_i .. source_destination_array[1].to_i+source_destination_array[2].to_i - 1),
          destination: source_destination_array[0].to_i
        }
      }.sort_by! { | element |  element[:source_range].min }
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
    new_seeds = []
    seeds.each { | seed |
      mapped_seeds = []
      unmapped_seeds = [seed]
      source_destination_array.each { | source_destination |
        if seed.max < source_destination[:source_range].min
          break
        end
        unless (seed.min > source_destination[:source_range].max)
          seed_to_be_mapped = unmapped_seeds.pop
          delta = (source_destination[:destination] - source_destination[:source_range].min)
          if (seed_to_be_mapped.min >= source_destination[:source_range].min && seed_to_be_mapped.max <= source_destination[:source_range].max) #seed is fully within window
            mapped_seeds.append((seed_to_be_mapped.min+delta..seed_to_be_mapped.max+delta))
          elsif (seed_to_be_mapped.min >= source_destination[:source_range].min && seed_to_be_mapped.max > source_destination[:source_range].max) #seed has more to right of window
            mapped_seeds.append(seed_to_be_mapped.min+delta..source_destination[:source_range].max+delta)
            unmapped_seeds.append(source_destination[:source_range].max+1..seed_to_be_mapped.max)
          elsif (seed.min < source_destination[:source_range].min && seed.max > source_destination[:source_range].max) # seed extends on both sides of window
            mapped_seeds.append(seed_to_be_mapped.min..source_destination[:source_range].min-1)
            mapped_seeds.append(source_destination[:source_range].min+delta..source_destination[:source_range].max+delta)
            unmapped_seeds.append(source_destination[:source_range].max+1..seed_to_be_mapped.max)
          elsif (seed.min < source_destination[:source_range].min && seed.max <= source_destination[:source_range].max) #seed has more to the left side of the window
            mapped_seeds.append(seed_to_be_mapped.min..source_destination[:source_range].min-1)
            mapped_seeds.append(source_destination[:source_range].min+delta..seed.max+delta)
          end
        end
      }
      unless unmapped_seeds.empty?
        mapped_seeds.append(unmapped_seeds)
      end
      new_seeds.append(mapped_seeds)
    }

    seeds = new_seeds.flatten
  end
  print(seeds.min{| e1, e2 | e1.min <=> e2.min})
end


solve("solution_five/question_input" )