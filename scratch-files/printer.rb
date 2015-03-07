require_relative '../lib/mastermind.rb'

my_board = Mastermind::Board.new(4, 4)
#Printer.print_row(my_board.rows)
my_board.rows[0] = ([:red, :blue, :green, :yellow])
my_board.rows[1] = ([:yellow, :green, :blue, :red])
my_board.rows[2] = ([:green, :yellow, :blue, :red])
my_board.rows[3] = ([:green, :yellow, :red, :blue])
#Printer.print_whole_row(my_board.rows.last).each {|v| puts v}
Printer.print_whole_board(my_board.rows)
