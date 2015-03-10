require 'spec_helper'

module Mastermind
  describe 'Knuth' do
    #let(:palette) { [:_1, :_2, :_3, :_4, :_5, :_6] }
    let(:palette) { Mastermind::CodePeg.keypeg_colors }
    let(:key_size) { 4 }
    let(:dk) { Knuth.new('donald knuth', key_size, palette) }

    #dk.history.each{|a| print a; puts}

    describe '#proto_guess' do
      context 'when @history is empty'
        it 'returns an initial guess where 1st two values are same. 2nd two are same' do
          ig = dk.proto_guess() 
          def test(arr)
            arr.each_with_index {|v, i| arr[i] == arr[i-1] if i % 2 != 0 }
          end
          expect(test(ig)).to be_truthy
        end
        it 'adds that guess to the @history variable' do
          ig = dk.proto_guess()
          expect(dk.history.last).to match_array ig
        end
    end
    describe 'comparing functions' do
      describe 'accessibility' do
        it 'are private methods, would raise an error if called normally' do
          expect{dk.count_hits(g1, g2)}.to raise_error NameError
          expect{dk.count_same_color_and_position(g1, g2)}.to raise_error NameError
          expect{dk.count_same_color_but_wrong_position(g1, g2)}.to raise_error NameError
        end
      end

      let (:g1) { [:white, :red, :yellow, :cyan] }
      let (:g2) { [:cyan, :yellow, :black, :white] }
      let (:g3) { [:cyan, :cyan, :red, :red] }
      let (:g4) { [:red, :yellow, :black, :white] }
      let (:g5) { [:murple, :murple, :snozzberry, :snozzberry] }

      describe '#count_hits' do
        it 'counts how many values in one array exist in another' do
          expect(dk.send(:count_hits, g1, g2)).to eq 3
        end
        it 'will not count duplicates' do
          expect(dk.send(:count_hits, g3, g4)).to eq 1
          expect(dk.send(:count_hits, g4, g3)).to eq 1
        end
      end
      describe '#count_same_color_and_position' do
        it 'counts number of values in same color & position' do
          expect(dk.send(:count_same_color_and_position, g2, g4)).to eq 3
          expect(dk.send(:count_same_color_and_position, g2, g3)).to eq 1
          expect(dk.send(:count_same_color_and_position, g1, g5)).to eq 0
          expect(dk.send(:count_same_color_and_position, g1, g3)).to eq 0
        end
      end
      describe '#count_same_color_but_wrong_position' do
        it 'counts number of values in same color but wrong position' do
          expect(dk.send(:count_same_color_but_wrong_position, g3, g1)).to eq 2
        end
      end
    end

    describe '#score' do
      let(:merv) { Codemaker.new('merv') }
      let(:guess1) { [:black, :black, :white, :white] }
      let(:hint_from_codemaker) { merv.give_hint(guess1) }
      it 'compares 1 guess to another guess returns a score as a Hash object' do
        stolen_secret_code = merv.send(:show_pattern)
        expect(dk.score(guess1, stolen_secret_code)).to eq hint_from_codemaker
      end
    end

  end
end
