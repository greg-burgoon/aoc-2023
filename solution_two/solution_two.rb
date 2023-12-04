# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

RED = " red"
BLUE = " blue"
GREEN = " green"

def parse_input(input)
  inputArray = input.split("\n")
  return inputArray.map! {
    |line|
    gameMap = {
      id: -1,
      red: [0],
      green: [0],
      blue: [0]
    }
    lineMap = line.split(":");
    gameMap[:id] = lineMap[0].delete("Game ")
    lineMap[1].split(";").each {
      |setToken|
      setToken.split(",").each {
        |colourToken|
        if colourToken.include?(RED)
          freq = colourToken.strip!.delete!(RED).to_i
          gameMap[:red].append(freq)
        elsif colourToken.include?(GREEN)
          gameMap[:green].append(colourToken.strip!.delete!(GREEN).to_i)
        else
          gameMap[:blue].append(colourToken.strip!.delete!(BLUE).to_i)
        end
      }
    }
    gameMap
  }
end
def solve(filename)
  input = Utilities.parse_file(filename: filename)
  gameMaps = parse_input(input)

  limitMap = {
    red: 12,
    green: 13,
    blue: 14
  }
  gameMaps.map! do  |game|
    game[:id].to_i unless game[:red].max > limitMap[:red] || game[:green].max > limitMap[:green] || game[:blue].max > limitMap[:blue]
  end.select! do |id|
    id != nil
  end
  print gameMaps.sum
end


solve("solution_two/question_input" )