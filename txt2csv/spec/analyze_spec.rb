require 'spec_helper'
require 'pry'
require 'analyze.rb'

# First, define methods used to create the test files.
# We create the test files here
#   1) so that the test can be run on its own and
#   2) so the contents of the file are clear

def create_test_customer_file(filename)
  File.open(filename, 'w') do |f|
    f.puts 'Mrs. Theresa E. Stamm 1-678-523-6736  Reinger kieran@runte.biz'
    f.puts 'Keara Maggio  1-399-471-4388 x9581  @Weber  cayla@lubowitz.com'
    f.puts 'Daren S. Padberg DVM  240-399-5583 x73790 Hessel  augusta@stoltenberg.com'
    f.puts 'Claud Auer  (561)024-9548 x165  @Mraz jettie_friesen@weber.com'
    f.puts 'Mrs. Sam Parisian 818-657-9309 x5633  @Quigley  lavon.quitzon@schinnercain.biz'
    f.puts 'Ciara X. Windler II 575-225-1469 x240 Labadie ryan_moore@hagenesmiller.com'
  end
end

def create_prefix_file(filename)
  # Note sort order - by count, not by word
  File.open(filename, 'w') do |f|
    f.puts 'Dr. 10'
    f.puts 'Miss 6'
    f.puts 'Mr. 5'
    f.puts 'Mrs. 4'
    f.puts 'Darleen 3'
    f.puts 'Frank 2'
    f.puts 'Jane 1'
  end
end

def create_suffix_file(filename)
  File.open(filename, 'w') do |f|
    f.puts 'Roberts 10'
    f.puts 'Smith 6'
    f.puts 'Jones 5'
    f.puts 'Wesson 4'
    f.puts 'Washington 3'
    f.puts 'Franklin 2'
    f.puts 'Wintermute 1'
  end
end


describe Analyze do

  # Set up the files need for the specifications
  # put them down in the spec folder so they don't clutter the project root folder

  before(:all) do
    create_test_customer_file 'spec/test_customer_file.txt'
    create_test_prefix_file 'spec/test_prefix_file.txt'
    create_test_suffix_file 'spec/test_suffix_file.txt'
  end

  # clean up after ourselves

  after(:all) do
    File.delete 'spec/test_customer_file.txt'
    File.delete 'spec/test_prefix_file.txt'
    File.delete 'spec/test_suffix_file.txt'
  end

  it 'should take a flag, input file and output file with extracted prefix or suffix' do
    `ruby lib/analyze.rb -t p -i test_customer_file.txt test_prefix_file.txt`
    IO.read('spec/histogram.txt').should == IO.read('spec/expected_prefixes.txt')
  end

  # it 'should interpret the switch and return the correct pattern' do
  #   return_pattern = @mock_analyze.get_type('p')
  #   expect(return_pattern).to eq (/^\S*/)
  # end

  # it 'should throw an error if inapplicable switch is used' do
  #   pending
  #   return_pattern = @mock_analyze.get_type('v')
  #   expect(return_error).to eq "Unknown type error."
  # end

  # it 'should read a file and return the name string' do
  #   pending
  #   return_string = @mock_analyze.parse_name_field.with("customer_file.txt")
  #   expect(return_string).to eq ('Miss First Last')
  # end

  # it 'should match a string and add/append to a histogram' do
  #   return_hash = @mock_analyze.analyze_input("Miss First Last", /^\S*/)
  #   expect(return_hash).to eq ({ :Miss => 1 })
  # end

  # it 'should write a hash to an output' do
  #   pending
  #   return_file = @mock_analyze.export_output
  #   IO.read('spec/histogram.txt').should == "Miss 1\n"
  # end


end
