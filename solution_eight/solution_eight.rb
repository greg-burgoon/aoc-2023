# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

START_NODE = "AAA"
END_NODE = "ZZZ"
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

  direction_ring = desert_map[:directions].chars.to_a
  nodes = desert_map[:graph_nodes]
  current_node = START_NODE
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
    count += 1
    if current_node == END_NODE
      break
    end
  end

  print(count)
end


solve("solution_eight/question_input" )