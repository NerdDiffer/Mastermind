module Mastermind
  class Game

    attr_reader :current_turn, :total_turns,
      :code_length, :maker, :breaker,
      :guess_board, :hint_board, :answer_board
    
    @@current_turn = 0

    def initialize(args)
      args[:total_turns] ||= 8
      args[:code_length] ||= 4

      @maker = Codemaker.new(args[:maker], args[:code_length], args[:pattern])
      @breaker = Codebreaker.new(args[:breaker])

      @total_turns = self.class.is_total_turns_valid?(args[:total_turns])
      @code_length = args[:code_length]

      @guess_board = GuessBoard.new(@code_length, @total_turns)
      @hint_board = HintBoard.new(@code_length, @total_turns)
      @answer_board = AnswerBoard.new(@code_length)
    end

    def self.current_turn()
      @@current_turn
    end

    def play()
      print_intro()
      is_game_over = false
      while not is_game_over
        do_one_turn()
        # important to do these before switching turns:
        is_game_over = check_game_over()
        @@current_turn += 1
      end
      print_outcome(is_game_over)
    end

    def print_intro()
      puts
      puts '**************'
      puts 'Beginning Play'
      puts '**************'
      puts "Codemaker: #{@maker.name}"
      puts "Codebreaker: #{@breaker.name}"
      puts "Number of Turns: #{@total_turns}"
      puts "Code Length: #{@code_length}"
    end

    def print_outcome(outcome)
      puts
      merged = Printer.merge_two_boards({
        guess_board: @guess_board, hint_board: @hint_board
      })
      Printer.print_board(merged)
      puts
      puts "GAME OVER"
      case outcome
      when :win
        puts "You win #{@breaker.name}!"
      when :loss
        puts "You lose #{@breaker.name}!"
      end
      puts "Here is the answer:"
      print_reveal_answer()
    end

    def do_one_turn()
      begin
        puts
        puts "You are on turn ##{(@@current_turn + 1)} of #{total_turns}"
        puts "You have #{@total_turns - @@current_turn} turns remaining (including the current turn)"
        merged = Printer.merge_two_boards({
          guess_board: @guess_board, hint_board: @hint_board
        })
        Printer.print_board(merged)
        puts
        puts "#{@breaker.name}: Enter a list of #{@code_length} colors, separated by spaces"
        guess = @breaker.make_guess(gets.chomp)
      rescue StandardError => e
        puts Printer.print_error_message(e)
        retry
      else
        @guess_board.receive(guess)
        hint = @maker.give_hint(guess)
        @hint_board.receive(hint)
        puts "You guessed: #{guess}"
        puts "The hint: #{hint}"
      end
    end

    def self.get_settings(prompt = nil)
      settings = {}
      puts
      if prompt
        puts "OK, customizing settings"
        puts
        # Step 1: get name for Codemaker
        puts "Step 1/5: Enter the name of the Codemaker"
        settings[:maker] = gets.chomp

        # Step 2: ask if Codemaker is a human or AI player.
        # If human then go to 3a, else go to 3b
        puts "Step 2/5: Is the Codemaker a human or a robot?"
        case gets.chomp.downcase.to_sym
        # Step 3a: if Codemaker is a human
        when :human
          puts "the Codemaker is a human"
          begin
            puts "Step 3/5: Enter a secret code"
            code = Codebreaker.new('').instance_eval {self.make_guess(gets.chomp)}
          rescue StandardError => e
            puts Printer.print_error_message(e)
            retry
          else
            settings[:pattern] = code
          end
        # Step 3b: if the Codemaker is not a human
        else
          puts "the Codemaker is AI"
          begin
            puts "Step 3/5: How many characters long is the secret code?"
            n = gets.chomp.to_i
            self.is_code_length_valid?(n)
          rescue ArgumentError => e
            puts Printer.print_error_message(e)
            retry
          else
            settings[:code_length] = n
          end
        end
        
        # Step 4: get name for Codebreaker
        puts "Step 4/5: Enter the name of Codebreaker"
        settings[:breaker] = gets.chomp
        
        # Step 5: ask how many turns the Codebreaker has
        begin
          puts "Step 5/5: How many turns will the Codebreaker have?"
          n = gets.chomp.to_i
          self.is_total_turns_valid?(n)
        rescue ArgumentError => e
          puts Printer.print_error_message(e)
          retry
        else
          settings[:total_turns] = n
        end
      else
        puts "Playing with default settings"
        settings[:maker] = 'Mordecai Meirowitz'
        settings[:breaker] = 'Boris Grishenko'
      end
      settings
    end

    def self.is_code_length_valid?(num)
      # must be (1..8)
      num = (num >= 1 && num <= 8) ?
        num :
        raise(ArgumentError, "Must be >= 1 and <= 8")
    end
    def self.is_total_turns_valid?(num)
      # must be an even number. must be (4..12)
      num = (num % 2 == 0 && num >= 4 && num <= 12) ?
        num :
        raise(ArgumentError, "Must be an even number where n >= 4 and n <= 12")
    end

    private
    def check_game_over()
      return :win if @hint_board.rows[@@current_turn].all?{|peg| peg == :black}
      # comparing @@current_turn to @total_turns - 1 
      # because @@current_turn is incremented after we call `check_game_over`
      return :loss if @@current_turn >= (@total_turns - 1)
      false
    end

    def print_reveal_answer()
      @answer_board.receive(@maker.send(:show_pattern))
      Printer.print_board(@answer_board)
    end

  end
end
