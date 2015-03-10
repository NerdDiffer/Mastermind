module Mastermind
  class Knuth < Codebreaker
    attr_reader :narrowed_set

    def initialize(name, key_size, unique_values) 
      @key_size = key_size
      @name = name
      all_possibilities = unique_values.repeated_permutation(key_size).to_a
      @narrowed_set = all_possibilities.map { |c| make_guess(c.join(' '))}
      @history = []
    end

    # only works when @key_size is 4
    def proto_guess(value)
      guess = []
      # the first guess is in the 1122 pattern
      if @history.empty?
        guess[0], guess[2] = random_color(), random_color()
        guess[1], guess[3] = guess[0], guess[2]
      else
        if @narrowed_set.empty?
          guess = make_blank_guess
        else
          guess = @narrowed_set[rand(0...@narrowed_set.length)] 
        end
      end
      if is_guess_valid?(guess)
        @history << guess
        return guess
      end
    end

    # tells you how many black pegs you would place
    # how many values are the same and also in the same position
    def compare(current_guess, another_guess)
      current_guess.zip(another_guess).map { |x,y| x<=> y }.count(0)
    end

    #def ==(current_guess, another_guess)
    #  compare(current_guess, another_guess) == current_guess.length
    #end

    def check_presence(current_guess, another_guess)
      num_present = 0
      compare_sequence = another_guess.clone

      current_guess.each do |x|
        if compare_sequence.include(x)
          num_present += 1
          compare_sequence.delete_at(compare_sequence.find_index(x))
        end
      end
      num_pres
    end

    def color_and_position(current_guess, another_guess)
      compare(current_guess, another_guess)
    end

    def color_but_not_position(current_guess, another_guess)
      p1 = check_presence(current_guess, another_guess)
      p2 = compare(current_guess, another_guess)
      p1 - p2
    end

    def score(current_guess, another_guess)
      fake_response = {black: 0, white: 0}
      fake_response[:black] = color_and_position(current_guess, another_guess)
      fake_response[:white] = color_but_not_position(current_guess, another_guess)
      fake_response
    end
    # block can be:
    #   `min` for getting minimum value
    #   `max` for getting maximum value
    def inject_total(unique_values, &block)
      unique_values.inject(0) do |total, num|
        n_in_code = count_hits(num, secret_code)
        n_in_guess = count_hits(num, guess)
        total += block.call(n_in_code, n_in_guess)
      end
    end

    def min(a,b)
      a >= b ? a : b
    end

    def max(a,b)
      a <= b ? a : b
    end

    private
    def make_blank_guess()
      guess = []
      @key_size.times { guess << random_color() }
      guess
    end

    def is_guess_valid?(guess)
      guess.all? { |s| Mastermind::CodePeg.is_color_correct?(s) }
    end

    def random_color()
      Mastermind::CodePeg.keypeg_colors.sample()
    end

    def remove_from_narrowed_set(value = @history.last)
      @narrowed_set.delete_if { |x| x == value }
      @narrowed_set.delete_if do |x|
        (x.score(value) <=> value.score(@code_to_guess)) != 0
      end
    end
    
    def count_hits(val, arr)
      arr.count(val)
    end

  end
end
