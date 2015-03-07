module Mastermind

  class Player
    attr_reader :name
    def initialize(name)
      @name = name
    end
  end

  class Codemaker < Player
    def initialize(name)
      @name = super
      @pattern = set_pattern
    end

    def give_hint(move)
      is_position_and_color_correct?(move)
    end

    private
    def show_pattern
      @pattern
    end

    def set_pattern(pattern = nil)
      arr = pattern.nil? ?
        Mastermind::CodePeg.keypeg_colors.sample(4) :
        pattern.map { |color| color }
      @pattern = arr
    end

    def is_color_correct?(peg)
      show_pattern().any? { |color| peg == color }
    end

    def is_position_and_color_correct?(move)
      pattern = show_pattern()
      response = {
        black:  0,
        white: 0,
      }

      move.each_with_index do |color, index|
        if color == pattern[index]
          response[:black] += 1
        elsif pattern.any?{ |peg| peg == color } #is_color_correct?(color)
          response[:white] += 1
        else
        end
      end
      response
    end
  end

  class Codebreaker < Player
    def make_move(*peg_colors)
      peg_colors
      #peg_colors.map { |color| CodePeg.new(color) }
      #peg_colors.map.with_index { |color, index| CodePeg.new(color) }
    end
  end

end
