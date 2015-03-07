require_relative './lib/mastermind.rb'

def get_settings(prompt = nil)
  settings = {}
  if prompt
    puts "Enter the name of the Codemaker"
    settings[:maker] = gets.chomp
    
    puts "How many characters long is the secret code?"
    settings[:code_length] = gets.chomp
    
    puts "Enter the name of Codebreaker"
    settings[:breaker] = gets.chomp
    
    puts "How many turns will the Codebreaker have? Must be an even number, >= 4 and <= 12"
    settings[:num_of_turns] = gets.chomp
  else
    settings[:maker] = 'Merv Griffin'
    settings[:breaker] = 'Brian Williams'
    #settings[:code_length] = 4
    #settings[:num_of_turns] = 8
  end
  settings
end

game = Mastermind::Game.new(get_settings())

puts game
puts game.num_of_turns
puts game.code_length
