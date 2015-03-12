##Mastermind
Object oriented programming with Ruby  
An exercise from [the Odin Project](http://www.theodinproject.com/ruby-programming/oop)

Mastermind is a game where the *Codebreaker* must guess the *Codemaker*'s secret code within a certain number of turns; it is like hangman with colored pegs.

Each turn, the Codebreaker gets some feedback from the Codemaker about how good the guess was -- whether it was exactly correct or that you just guessed the correct color in the wrong space.
* If one of your guess pegs is the right color and in the right place, then the Codemaker places adds a *black* peg to the hint.  
* If one of your guess pegs is right color but in the wrong place, then the Codemaker places adds a *white* peg to the hint.  

The position of the hint pegs gives no indication as to which of your guess pegs was correct. One hint peg corresponds to any one of your guess pegs. Though black pegs will always be placed before white pegs.

Read more about Mastermind on [Wikipedia](http://www.en.wikipedia.org/wiki/Mastermind_(board_game)/)

####run tests
to run all tests: `rspec` from home directory  
to run a test of a certain file: `rspec path/to/file`  

###how to play
be sure to install the **colorize** gem:  
`gem install colorize`  

want to play(against yourself)?  
`ruby let_us_play.rb` from this project's home directory  

You can play with a code whose length is up to 6. Going beyond that is not recommended for most computers.  
If you choose a code length of 5 or 6 and you are waiting for the AI to make a move, it might be computing some internal variables. *Please be patient!* Or just interrupt the process and choose a lower code length.
