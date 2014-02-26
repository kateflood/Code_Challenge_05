require 'spec_helper'

require 'parse.rb'

describe Parse do
  before(:each) do
    @instance = Parse.new('lib/prefixfile.txt', 'lib/suffixfile.txt', 'lib/test.txt', 'lib/namefile.csv')
  end

  it 'should parse with ampersand' do
    return_array = @instance.parse_twitter('@poohbear')
    expect(return_array).to eq(['poohbear'])
  end

  it 'should parse without ampersand' do
    return_array = @instance.parse_twitter('tigger')
    expect(return_array).to eq(['tigger'])
  end
end
