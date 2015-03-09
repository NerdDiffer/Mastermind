module Mastermind
  class Peg

    attr_reader :color, :size, :keypeg_colors

    def initialize(color)
      if self.class.is_color_correct?(color)
        @color = color
      else
        raise ArgumentError.new
      end
    end

    def self.keypeg_colors; @keypeg_colors; end

    def self.is_color_correct?(color)
      not @keypeg_colors.find_index(color).nil?
    end

  end

  class CodePeg < Peg
    @keypeg_colors = [:black, :red, :green, :yellow,
                      :blue, :magenta, :cyan, :white]
  end

  class KeyPeg < Peg
    @keypeg_colors = [:black, :white]
  end
end
