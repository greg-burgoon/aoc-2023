# frozen_string_literal: true
require_relative '../utilities'

DIGIT_KEYS = %w[1 2 3 4 5 6 7 8 9 one two three four five six seven eight nine]
CLEAN_KEY_MAP = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
}

def addIndexToMap(digitsMap, key, index)
  if digitsMap[key] && index != nil
    digitsMap[key].append(index)
  elsif index != nil
    digitsMap[key] = [index]
  end
end

def cleanKey(key)
  cleanKey = key
  if cleanKey.to_i.to_s != key
    cleanKey = CLEAN_KEY_MAP[key.to_sym]
  end
  cleanKey
end

def generateDigitsMap(line)
  digitsMap = {}
  DIGIT_KEYS.each { |key|
    firstIndex = line.index(key)
    lastIndex = line.rindex(key)
    addIndexToMap(digitsMap, key, firstIndex)
    addIndexToMap(digitsMap, key, lastIndex)
  }
  digitsMap
end

def solve(filename)
  input = Utilities.parse_file(filename: filename)
  inputArray = input.split("\n")
  inputArray.map! { |line|
    digitsMap = generateDigitsMap(line)
    lowest = digitsMap.to_a.min { |a,b| a.last.to_a.min.to_i <=> b.last.to_a.min.to_i}
    highest = digitsMap.to_a.max { |a,b| a.last.to_a.max.to_i <=> b.last.to_a.max.to_i}
    result = (cleanKey(lowest.first).to_s + cleanKey(highest.first).to_s).to_i
    result
  }
  print(inputArray.sum)
end


solve("solution_one/question_input")