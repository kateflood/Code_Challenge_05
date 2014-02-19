require 'spec_helper'

require 'parse.rb'

describe Parse do

  it 'should parse with ampersand' do
    return_array = Parse.parse_twitter('@poohbear')
    expect(return_array).to eq(['poohbear'])
  end

  it 'should parse without ampersand' do
    return_array = Parse.parse_twitter('tigger')
    expect(return_array).to eq(['tigger'])
  end
end
