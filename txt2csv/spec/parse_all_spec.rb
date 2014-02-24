require 'spec_helper'
require 'parse.rb'

prefixes = %w(M. Mrs. Mr. Dr. Ms. Sister Lady)
suffixes = %w(Jr. Sr. II III IV PhD.)

describe Parse do
  it 'should initialize an instance of Parse with input & ouput' do
    expect(Parse.new("lib/test.txt", "histogram.txt")).to be()
  end

  it 'should open the input file and split lines into arrays' do
    test = Parse.split_input('lib/test.txt')
    # binding.pry
    expect(test).to match_array(["Mrs. Theresa E. Stamm", "1-678-523-6736", "Reinger", "kieran@runte.biz"])
  end

  # it 'should send the first element of each array to the parse_names method'
  #   pending
  #   expect(Parse.parse_lines).to include()
  # end
end