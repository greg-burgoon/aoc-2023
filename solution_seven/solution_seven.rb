# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

HAND_TYPES = {
  high_card: 1,
  one_pair: 2,
  two_pair: 3,
  three_of_a_kind: 4,
  full_house: 5,
  four_of_a_kind: 6,
  five_of_a_kind: 7,
}

def parse_input(input)
  input_array = input.split("\n")
  input_array.map! { | line |
    split_line = line.split(" ")
    hand = split_line[0]
    bid = split_line[1]
    hand_map = {}
    hand.each_char { |c|
      hand_map[c] = hand_map[c] ? hand_map[c] + 1 : 1
    }
    hand_hex = ("0x"+hand.each_char.map { |c|
      if c.to_i.to_s == c
        c
      else
        if c == "T"
          "A"
        elsif c == "J"
          "B"
        elsif c == "Q"
          "C"
        elsif c == "K"
          "D"
        else
          "E"
        end
      end
    }.join).hex
    hand_makeup = hand_map.keys.inject(1) { |memo, el| hand_map[el].to_i * memo.to_i }
    hand_rank = case hand_map.keys.count
                when 5
                  HAND_TYPES[:high_card]
                when 4
                  HAND_TYPES[:one_pair]
                when 3
                  if hand_makeup == 4
                    HAND_TYPES[:two_pair]
                  else
                    HAND_TYPES[:three_of_a_kind]
                  end
                when 2
                  if hand_makeup == 6
                    HAND_TYPES[:full_house]
                  else
                    HAND_TYPES[:four_of_a_kind]
                  end
                else
                  HAND_TYPES[:five_of_a_kind]
                end
    {
      hand:,
      hand_hex:,
      bid:,
      hand_map:,
      hand_rank:
    }
  }
end
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  hands = parse_input(input)
  hands.sort! do |e1, e2 |
    if e1[:hand_rank] == e2[:hand_rank]
      e1[:hand_hex] <=> e2[:hand_hex]
    else
      e1[:hand_rank] <=> e2[:hand_rank]
    end
  end
  hand_values = []
  hands.each_with_index do |element, index|
    hand_values.append(element[:bid].to_i * (index+1))
  end

  print(hand_values.sum)
end


solve("solution_seven/question_input" )