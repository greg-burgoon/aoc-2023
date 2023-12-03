# frozen_string_literal: true

class Utilities
  def self.parse_file(filename:)
    file = File.open(filename)
    input =  file.read
    file.close
    input
  end
end
