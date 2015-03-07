require 'spec_helper'

module Mastermind
  describe 'Board' do
    let(:board)   { Board.new(4, 8) }

    describe '#new' do
      it 'has 4 columns' do
        expect(board.num_columns).to eq 4
      end
      it 'has 8 rows' do
        expect(board.num_rows).to eq 8
      end
    end
  end

  describe 'GuessBoard' do
    let(:guess_board) { GuessBoard.new(4, 8) }
    let(:merv)    { Codemaker.new('merv') }
    let(:bosco)   { Codebreaker.new('bosco') }

    describe '#place' do
      it 'receives the player guess as an array and adds to @row' do
        move = bosco.make_move(:blue, :orange, :yellow, :brown)
        answer = [:blue, :orange, :yellow, :brown]
        guess_board.send(:place, move)
        expect(guess_board.rows.last).to eq answer
      end
    end
  end

  describe 'HintBoard' do
    let(:hint_board) { HintBoard.new(4, 8) }
    let(:merv)    { Codemaker.new('merv') }
    let(:bosco)   { Codebreaker.new('bosco') }
    preset_colors = [ :white, :black, :orange, :yellow ]

    describe '#receive' do
      context 'when there are no matches' do
        it 'returns an array of nil values' do
          merv.send(:set_pattern, preset_colors)
          hint = { black: 0, white: 0}
          answer = [ nil, nil, nil, nil ]
          expect(hint_board.receive(hint)).to eq answer
        end
      end
      context 'receiving mix of white pegs & black pegs,' do
        it 'returns an array of symbols: black pegs first, then white pegs' do
          merv.send(:set_pattern, preset_colors)
          #hint = { black: 2, white: 1 }
          hint = merv.give_hint(bosco.make_move(:black, :blue, :orange, :yellow))
          answer  = [ :black, :black, :white, nil ]
          expect(hint_board.receive(hint)).to eq answer
        end
      end
      context 'receiving pegs of the same color,' do
        it 'returns an array of symbols' do
          merv.send(:set_pattern, preset_colors)
          #hint = { black: 0, white: 3 }
          hint = merv.give_hint(bosco.make_move(:black, :blue, :yellow, :orange))
          answer  = [ :white, :white, :white, nil ]
          expect(hint_board.receive(hint)).to eq answer
        end
      end
    end 
    describe '#place' do
      it 'before placing the hint on the board, last value of row is nil array' do
        expect(hint_board.rows.last.all?{|v| v.nil?}).to eq true
      end
      it 'receives the player guess as an array and adds to @row' do
        merv.send(:set_pattern, preset_colors)
        hint = merv.give_hint(bosco.make_move(:black, :blue, :brown, :orange))
        hint_board.send(:place, hint_board.receive(hint))
        answer = [:white, :white, nil, nil]
        expect(hint_board.rows.last).to eq answer
      end
    end
  end

  describe 'AnswerBoard' do
    let(:answer_board) { AnswerBoard.new(4) }
  end
end
