require 'spec_helper'
require 'parse.rb'



describe Parse do
  instance = Parse.new('lib/prefixfile.txt', 'lib/suffixfile.txt')
  it 'should initialize an instance of Parse with prefix and suffix files' do
    expect(instance).to be_instance_of(Parse)
  end

  it 'should open the input file and split lines into arrays' do
    expect(instance.split_input('lib/test.txt')).to match_array([["Mrs. Theresa E. Stamm", "1-678-523-6736", "Reinger", "kieran@runte.biz"], ["Mrs. Theresa E. Stamm", "1-678-523-6736", "Reinger", "kieran@runte.biz"], ["Keara Maggio", "1-399-471-4388 x9581", "@Weber", "cayla@lubowitz.com"], ["Daren S. Padberg DVM", "240-399-5583 x73790", "Hessel", "augusta@stoltenberg.com"]])
  end

  # it 'should send the first element of each array to the parse_names method'
  #   pending
  #   expect(Parse.parse_lines).to include()
  # end
end