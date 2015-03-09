def make_move(peg_colors)
  peg_colors.split(' ').map{|c| c.to_sym}
end

input = 'blue red orange yellow'
print make_move(input)
puts
