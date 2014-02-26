require 'spec_helper'
require 'parse.rb'

describe Parse do
  before(:each) do
    @instance = Parse.new('lib/prefixfile.txt', 'lib/suffixfile.txt', 'lib/test.txt', 'lib/namefile.csv')
  end

  it 'should initialize an @instance of Parse with prefix, suffix, and input files' do
    expect(@instance).to be_instance_of(Parse)
  end

  # it 'should send the first element of each array to the parse_names method'
  #   pending
  #   expect(Parse.parse_lines).to include()
  # end
end
