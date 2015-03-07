require_relative '../lib/mastermind.rb'

guess_board = Mastermind::GuessBoard.new(8, 4)
hint_board = Mastermind::HintBoard.new(4, 4)
#Printer.print_row(guess_board.rows)
guess_board.rows[0] = ([:red, :blue, :green, :yellow, :black, :white, :cyan, :magenta])
guess_board.rows[1] = ([:yellow, :green, :blue, :red])
guess_board.rows[2] = ([:green, :yellow, :blue, :red])
guess_board.rows[3] = ([:green, :yellow, :red, :blue])

hint_board.rows[0] = ([:white, :white, nil, nil])
hint_board.rows[1] = ([:black, :black, :black, nil])
hint_board.rows[2] = ([:black, :white, nil, nil])
hint_board.rows[3] = ([nil, nil, nil, nil])

guess_board.rows.each {|row| puts Printer.print_whole_row(row, 3)}
puts
#Printer.print_whole_row(guess_board.rows.last).each {|v| puts v}
#Printer.print_whole_board(guess_board.rows, 1)
Printer.print_whole_board(hint_board.rows, 1)
