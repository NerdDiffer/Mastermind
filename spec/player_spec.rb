require 'spec_helper'

module Mastermind
  describe 'Player' do
    let (:peterman) { Player.new('peterman') }
    it 'each player has a name' do
      expect(peterman.name).to eq 'peterman'
    end
  end

  describe 'Codemaker' do
    preset_colors = [ :white, :black, :orange, :yellow ]
    let (:merv) { Codemaker.new('merv') }
    let (:pattern) { merv.send(:set_pattern, preset_colors) }

    describe '#give_hint' do
      let(:bosco) { Codebreaker.new('bosco') }

      context "Codebreaker guesses 0 correct" do
        it "Codemaker places no pegs" do
          merv.send(:set_pattern, preset_colors)
          move = bosco.make_move(:red, :blue, :green, :brown)
          answer = { black: 0, white: 0 }
          expect(merv.give_hint(move)).to eq answer
        end
      end
      context "Codebreaker guesses some of the correct color, but none of which are in correct position:" do
        it "Codemaker places all white key-pegs, one for each correct guess" do
          merv.send(:set_pattern, preset_colors)
          move = bosco.make_move(:black, :white, :yellow, :orange)
          answer = { black: 0, white: 4 }
          expect(merv.give_hint(move)).to eq answer
        end
      end
      context "Codebreaker guesses some of the correct color, and all of those of correct color are also in the correct position:" do
        it "Codemaker places all black key-pegs, one for each correct guess" do
          merv.send(:set_pattern, preset_colors)
          move = bosco.make_move(:white, :black, :orange, :yellow)
          answer = { black: 4, white: 0 }
          expect(merv.give_hint(move)).to eq answer
        end
      end
      context "Codebreaker guesses some of correct color & some of correct position:" do
        it "Codemaker places one black key-peg for each guess that's the correct color & the correct position" do
          merv.send(:set_pattern, preset_colors)
          move = bosco.make_move(:blue, :brown, :orange, :yellow)
          answer = {black: 2, white: 0}
          expect(merv.give_hint(move)).to eq answer
        end
        it "Codemaker places one white key-peg for each code-peg that's the correct color but wrong position" do
          merv.send(:set_pattern, preset_colors)
          move = bosco.make_move(:orange, :yellow, :blue, :brown)
          answer = {black: 0, white: 2}
          expect(merv.give_hint(move)).to eq answer
        end
      end
    end

    describe '#set_pattern' do
      it 'is a private method' do
        expect{merv.set_pattern}.to raise_error NameError
      end
      context 'when passed nothing,' do
        it 'returns an array of CodePeg color choices, each is valid color' do
          expect(merv.send(:set_pattern).all? { |c| CodePeg.is_color_correct?(c) }).to eq true
        end
        #xit 'sets the instance variable, `@pattern` of the object' do
        #end
      end
      context 'when passed an array of symbols,' do
        it 'can be overridden by passing specific colors as symbols' do
          answer = [:white, :black, :orange, :yellow]
          expect(pattern).to eq answer
        end
        #xit 'sets the instance variable, `@pattern` of the object' do
        #end
      end
    end

    describe '#is_color_correct?' do
      it 'is a private method' do
        expect{merv.is_color_correct?}.to raise_error NameError
      end
      it 'is passed a peg to compare to a pattern, returns true if the color is found in pattern' do
        merv.send(:set_pattern, preset_colors)
        expect(merv.send(:is_color_correct?, :orange)).to eq true
      end
    end

  end

  describe 'Codebreaker' do
    let(:merv) { Codemaker.new('merv') }
    let(:bosco) { Codebreaker.new('bosco') }

    it "cannot see the codemaker's pattern" do
      expect{merv.show_pattern}.to raise_error
    end

    describe '#make_move' do
      it 'accepts a list of symbols, returns an array of symbols' do
        answer = [:blue, :white, :orange, :yellow]
        expect(bosco.make_move(:blue, :white, :orange, :yellow)).to eq answer
      end
    end
  end

end
