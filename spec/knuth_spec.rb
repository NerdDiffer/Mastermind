require 'spec_helper'

module Mastermind
  describe 'Knuth' do
    let(:numbers) { [1,2,3] }
    let(:key_size) { 3 }
    let(:k) { Knuth.new(key_size, numbers) }
    let(:initial_guess) { [1,1,2,2] }
    
    describe '#guess' do
      it 'returns an initial guess of [1,1,2,2]' do
        expect(k.guess(initial_guess)).to eq [1,1,2,2]
      end
    end
    
    describe '#remove_from_narrowed_set' do
      let(:narrowed_set) { Knuth.get_set(3, numbers) }
    
      it 'when a guess is made, that guess is removed from narrowed_set' do
        k.guess(initial_guess)
        k.remove_from_narrowed_set(initial_guess)
        expect(k.narrowed_set.find_index(initial_guess)).to be_nil
      end
    end
  end
end
