require 'spec_helper'

module Mastermind
  describe 'Peg' do
  end

  describe 'CodePeg' do
    describe '#new' do
      it 'is a sub-class of Peg' do
        expect(CodePeg.new(:yellow).class.superclass).to eq Mastermind::Peg
      end
      context 'takes any colors from the array,' do
        it 'does not raise an error when passed :red' do
          expect{CodePeg.new(:red)}.not_to raise_error
        end
        it 'throws an error when passing another color' do
          expect{CodePeg.new(:psychedelica)}.to raise_error
        end
      end
    end
    describe '.is_color_correct?,' do
      it 'is false when color is NOT part of colors array' do
        expect(CodePeg.is_color_correct?(:not_even_a_color)).to eq false
      end
    end
  end

  describe 'KeyPeg' do
    describe '#new' do
      it 'is a sub-class of Peg' do
        expect(KeyPeg.new(:white).class.superclass).to eq Mastermind::Peg
      end
      context'only allows :black and :white as possible colors,' do
        it 'does not raise an error when passed :black' do
          expect{KeyPeg.new(:black)}.not_to raise_error
        end
        it 'does not raise an error when passed :white' do
          expect{KeyPeg.new(:white)}.not_to raise_error
        end
        it 'throws an error when passing another color' do
          expect{KeyPeg.new(:green)}.to raise_error
        end
      end
    end
    describe '.is_color_correct?,' do
      it 'is false when color is NOT :black, or :white' do
        expect(KeyPeg.is_color_correct?(:green)).to eq false
      end
    end
  end
end
