require 'spec_helper'

#module Board
  #module Printer
    describe 'Printer' do
      let(:guess_board)   { Mastermind::GuessBoard.new(4, 8) }
      let(:hint_board)    { Mastermind::HintBoard.new(4, 8) }
      let(:answer_board)  { Mastermind::AnswerBoard.new(4) }

      let(:last_row1) { [:yellow, :green, :blue, :red] }
      let(:last_row2) { [:red, :blue, :green, :yellow] }

      describe '.hello_world' do
        it 'prints contents of the constants' do
          expect(Printer.hello_world).to eq('|=-')
        end
      end

      describe '.print_top_bottom_border' do
        it 'the size of output depends on contents of row' do
          answer = '--------|-------|------|-----'
          expect(Printer.print_horizontal_border(last_row1, :minor)).to eq answer
        end
        it 'prints ROW_HORIZONTAL_MINOR_BORDER by default' do
          answer = '--------|-------|------|-----'
          expect(Printer.print_horizontal_border(last_row1)).to eq answer
        end
        it 'can print ROW_HORIZONTAL_MAJOR_BORDER on demand' do
          answer = '=====|======|=======|========'
          expect(Printer.print_horizontal_border(last_row2, :major)).to eq answer
        end
      end

      describe '.print_row_contents' do
        it 'the size of output depends on contents of row' do
          answer = ' yellow | green | blue | red '
          expect(Printer.print_row_contents(last_row1)).to eq answer
        end
      end

      describe '.print_whole_row' do
        it 'wraps up 2 other functions to return border & contents as array' do
          top = '--------|-------|------|-----'
          middle = ' yellow | green | blue | red ' 
          answer = [top, middle]
          expect(Printer.print_whole_row(last_row1)).to eq answer
        end
      end

      describe '.set_horizontal_border' do
        it 'returns ROW_HORIZONTAL_MINOR_BORDER by default' do
          expect(Printer.set_horizontal_border).to eq Printer::ROW_HORIZONTAL_MINOR_BORDER
        end
        it 'returns ROW_HORIZONTAL_MAJOR_BORDER when passed `:major`' do
          expect(Printer.set_horizontal_border(:major)).to eq Printer::ROW_HORIZONTAL_MAJOR_BORDER
        end
      end

    end
  #end
#end
