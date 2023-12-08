# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

START_NODE_SUFFIX = "A"
END_NODE_SUFFIX = "Z"
LEFT = "L"
RIGHT = "R"
def parse_input(input)
  input_array = input.split("\n\n")
  directions = input_array.first
  graph_nodes = input_array.last.split("\n").map { | line |
    node_data = line.split(" = ")
    [
      node_data.first.to_sym, node_data.last.delete_prefix("(").delete_suffix(")").split(", ")
    ]
  }.to_h
  {
    directions:,
    graph_nodes:
  }
end
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  desert_map = parse_input(input)

  nodes = desert_map[:graph_nodes]
  current_nodes = nodes.select { |key, value|
    key.to_s.chars.last == START_NODE_SUFFIX
  }.keys

  count_maps = []

  current_nodes.each_with_index do |current_node, index|
    count_map = desert_map[:directions].chars.to_a.map{|d| 0}
    direction_ring = desert_map[:directions].chars.to_a
    count = 0
    while (true)
      current_direction = direction_ring.shift
      direction_ring.append(current_direction)
      case current_direction
      when LEFT
        current_node = nodes[current_node.to_sym].first
      when RIGHT
        current_node = nodes[current_node.to_sym].last
      end
      if current_node.to_s.chars.last == END_NODE_SUFFIX
        if count_map[count%direction_ring.size] == 0
          count_map[count%direction_ring.size] = count+1
        else
          break
        end
      end
      count += 1
    end
    count_maps.append(count_map)
  end

  direction_map = desert_map[:directions].chars.to_a.each_with_index.map { |el , index|
    count_maps.map { |el| el[index]}
  }

  print(direction_map.map{ |el| el.map{|el| el==0 ? 1 : el}.reduce(1, :lcm) }.reduce(1, :lcm))
end


solve("solution_eight/question_input" )