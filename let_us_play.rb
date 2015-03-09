require_relative './lib/mastermind.rb'

settings = Mastermind::Game.get_settings(:true)
game = Mastermind::Game.new(settings)

#preset_colors = [ :yellow, :magenta, :black, :white ]
#game.maker.send(:set_pattern, {pattern: preset_colors})

game.play
