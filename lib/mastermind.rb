module Mastermind
  class Game; end
  class Player; end
  class Board; end
  class Peg; end
end

Mastermind.constants.each do |c|
  c_length = c.to_s.length
  class_file = Mastermind.const_get(c).
    to_s.slice('Mastermind::'.length, c_length).downcase
  require_relative class_file
end
