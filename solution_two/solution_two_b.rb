# frozen_string_literal: true

# frozen_string_literal: true
require_relative '../utilities'

RED = " red"
BLUE = " blue"
GREEN = " green"

def parseInput(input)
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
  gameMaps = parseInput(input)

  gameMaps.map! do  |game|
    (game[:red].max * game[:green].max * game[:blue].max).to_i
  end
  print gameMaps.sum
end


solve("solution_two/question_input" )