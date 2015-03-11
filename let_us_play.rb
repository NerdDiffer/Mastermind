require_relative './lib/mastermind.rb'

settings = Mastermind::Game.get_settings(:true)
game = Mastermind::Game.new(settings)

game.play
