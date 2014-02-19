require 'spec_helper'

require 'parse.rb'

describe Parse do

  it 'should parse dashes and digits' do
    return_array = Parse.parse_phone('123-456-7890')
    expect(return_array).to eq(['', '123', '456', '7890', ''])
  end

  it 'should parse parenthesis and digits' do
    return_array = Parse.parse_phone('(123)456-7890')
    expect(return_array).to eq(['', '123', '456', '7890', ''])
  end

  it 'should parse dashes and country code' do
    return_array = Parse.parse_phone('1-123-456-7890')
    expect(return_array).to eq(['1', '123', '456', '7890', ''])
  end

  it 'should parse dots and digits' do
    return_array = Parse.parse_phone('123.456.7890')
    expect(return_array).to eq(['', '123', '456', '7890', ''])
  end

  it 'should parse dots and extension' do
    return_array = Parse.parse_phone('123.456.7890 x1234')
    expect(return_array).to eq(['', '123', '456', '7890', '1234'])
  end

  it 'should parse dashes and extension' do
    return_array = Parse.parse_phone('123-456-7890 x1234')
    expect(return_array).to eq(['', '123', '456', '7890', '1234'])
  end

  it 'should parse dashes and whole enchilada' do
    return_array = Parse.parse_phone('1-123-456-7890 x1234')
    expect(return_array).to eq(%w(1 123 456 7890 1234))
  end

  it 'should parse parenthesis and extension' do
    return_array = Parse.parse_phone('(123)-456-7890 x1234')
    expect(return_array).to eq(['', '123', '456', '7890', '1234'])
  end

end
