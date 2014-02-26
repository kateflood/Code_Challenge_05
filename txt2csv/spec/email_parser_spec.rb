require 'spec_helper'

require 'parse.rb'

describe Parse do
  before(:each) do
    @instance = Parse.new('lib/prefixfile.txt', 'lib/suffixfile.txt', 'lib/test.txt', 'lib/namefile.csv')
  end

  it 'should return regular domain format' do
    return_array = @instance.parse_email('trav.wurz@poohbear.com')
    expect(return_array).to eq(['trav.wurz@poohbear.com'])
  end

  it 'should return error email statement' do
    return_array = @instance.parse_email('tigger')
    expect(return_array).to eq(['not found'])
  end

  it 'should return error email statement' do
    return_array = @instance.parse_email('@tigger.com')
    expect(return_array).to eq(['not found'])
  end

  it 'should return error email statement' do
    return_array = @instance.parse_email('tigger.com')
    expect(return_array).to eq(['not found'])
  end

  it 'should return error email statement' do
    return_array = @instance.parse_email('trav.sdftigger.com')
    expect(return_array).to eq(['not found'])
  end
end
