require_relative '../scratch-files/knuth'


describe 'get_set' do
  numbers = [1,2,3]
  key_size = 3
  alotta_numbers = [
    [1,1,1], [1,1,2], [1,1,3], 
    [1,2,1], [1,2,2], [1,2,3],
    [1,3,1], [1,3,2], [1,3,3],

    [2,1,1], [2,1,2], [2,1,3],
    [2,2,1], [2,2,2], [2,2,3],
    [2,3,1], [2,3,2], [2,3,3],

    [3,1,1], [3,1,2], [3,1,3],
    [3,2,1], [3,2,2], [3,2,3],
    [3,3,1], [3,3,2], [3,3,3]
  ]

  it 'gets the right answer' do
    expect(get_set(key_size, numbers)).to match_array(alotta_numbers)
  end
  it 'gives an answer that is `key_size` to the `number.length` power long' do
    answer = key_size**numbers.length
    expect(get_set(key_size, numbers).length).to eq(answer)
  end
end
