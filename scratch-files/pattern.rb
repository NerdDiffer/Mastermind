require_relative '../lib/peg.rb'
require_relative '../lib/player.rb'

#cp = Mastermind::CodePeg.new(:red)
#kp = Mastermind::KeyPeg.new(:black)
#puts cp.class.keypeg_colors
#puts
#puts kp.class.keypeg_colors

merv = Mastermind::Codemaker.new('merv')
pattern = merv.send(:make_pattern)
puts pattern
arr = [:white, :black, :orange, :yellow]
puts merv.make_pattern
