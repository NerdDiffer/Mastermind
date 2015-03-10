module Mastermind
  class Knuth < Codebreaker
    attr_reader :narrowed_set, :history

    def initialize(name, key_size, unique_values) 
      @history = []
      @name = name
      @key_size = key_size
      @palette = unique_values
      all_possibilities = @palette.repeated_permutation(key_size).to_a
      @narrowed_set = all_possibilities.map do |c|
        make_guess(c.join(' '), @palette)
      end
    end

    # only works when @key_size is 4
    def proto_guess()
      guess = []
      # the first guess is in the 1122 pattern
      if @history.empty?
        guess[0], guess[2] = random_color(), random_color()
        guess[1], guess[3] = guess[0], guess[2]
      else
        if @narrowed_set.empty?
          guess = make_blank_guess()
        else
          guess = @narrowed_set[rand(0...@narrowed_set.length)] 
        end
      end
      if is_guess_valid?(guess)
        @history << guess
        return guess
      else
        raise(KeyError, "at least one of the values is not part of @palette")
      end
    end

    def remove_from_narrowed_set(hint_from_codemaker, value = @history.last)
      @narrowed_set.delete_if { |x| x == value }
      @narrowed_set.delete_if do |x|
        hint_from_codemaker != score(x, value)
      end
    end

    # mimics the Codemaker's private method, rate_guess
    def score(current_guess, another_guess)
      g1 = current_guess
      g2 = another_guess

      fake_response = {black: 0, white: 0}
      fake_response[:black] = count_same_color_and_position(g1, g2)
      fake_response[:white] = count_same_color_but_wrong_position(g1, g2)
      fake_response
    end

    private
    def make_blank_guess()
      guess = []
      @key_size.times { guess << random_color() }
      guess
    end

    def is_guess_valid?(guess)
      guess.all? { |s| @palette.member?(s) }
    end

    def random_color()
      @palette.sample()
    end

    def count_hits(current_guess, another_guess)
      num_present = 0
      compare_sequence = another_guess.clone

      current_guess.each do |x|
        if compare_sequence.include?(x)
          num_present += 1
          compare_sequence.delete_at(compare_sequence.find_index(x))
        end
      end
      num_present
    end

    def count_same_color_and_position(arr1, arr2)
      count = 0
      arr1.each_with_index do |value, index|
        count += 1 if value == arr2[index]
      end
      count
    end

    def count_same_color_but_wrong_position(current_guess, another_guess)
      p1 = count_hits(current_guess, another_guess)
      p2 = count_same_color_and_position(current_guess, another_guess)
      p1 - p2
    end

  end
end
