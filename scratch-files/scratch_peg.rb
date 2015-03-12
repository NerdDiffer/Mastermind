require_relative '../lib/mastermind.rb'

p = Mastermind::KeyPeg.new(:black)
puts p.class.superclass
