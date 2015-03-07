# given 4 pegs & 6 colors, there are 6**4 (1296) different patterns
#   assuming you are allowing duplicates

# 1. create set of 1296 possible codes
#   1111, 1112, 1113..6666
#   call that set, S

def get_set(key_size, unique_values)
  unique_values.repeated_permutation(key_size).to_a
end

# 2. start with initial guess 1122
# 3. play the guess to get response of colored & white pegs
# 4. if response is 4 colored pegs, then game is won 
# 5. otherwise, remove any code from S that would NOT give same response
#   if the guess were the code
# 6. apply minimax technique to find the next guess
#   a) 
# 7. repeat from step 3
