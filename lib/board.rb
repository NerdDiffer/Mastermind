require_relative 'printer'

module Mastermind
  class Board
    include Printer
    attr_reader :num_columns, :num_rows, :rows

    def initialize(num_columns, num_rows)
      @num_columns = num_columns
      @num_rows = num_rows
      @rows = reset_rows(num_columns, num_rows)
    end

    def receive(guess_or_response)
    end

    private
    def reset_rows(num_columns, num_rows)
      rows = []
      num_rows.times { rows << Array.new(num_columns) }
      rows
    end

    def place(guess_or_response)
      @rows.pop
      @rows.push(guess_or_response)
      guess_or_response
    end

  end

  class GuessBoard < Board
  end

  class HintBoard < Board
    def receive(response)
      hint = []
      response[:black].times { hint << :black }
      response[:white].times { hint << :white }
      (@num_columns - hint.length).times { hint << nil }
      place(hint)
    end
  end

  class AnswerBoard < Board
    def initialize(num_columns)
      @num_columns = num_columns
      @num_rows = 1
      @shielded = true
    end
  end
end
