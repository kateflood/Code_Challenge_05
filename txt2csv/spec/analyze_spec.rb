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
    f.puts 'Keara Maggio 1-399-471-4388 x9581  @Weber  cayla@lubowitz.com'
    f.puts 'Daren S. Padberg DVM  240-399-5583 x73790 Hessel  augusta@stoltenberg.com'
    f.puts 'Mrs. Sam Parisian 818-657-9309 x5633  @Quigley  lavon.quitzon@schinnercain.biz'
    f.puts 'Ciara X. Windler II 575-225-1469 x240 Labadie ryan_moore@hagenesmiller.com'
    f.puts 'Dr. Bins  1-543-553-4396 x596 Borer kay@abbottmoen.org'
    f.puts 'Brandyn Sawayn MD 976-736-2127  @Weber  brenna@frami.biz'
    f.puts 'Abdul Halvorson DVM 511-476-6661  @Casper jeanne@friesen.biz'
  end
end

def create_test_prefix_file(filename)
  # Note sort order - by count, not by word
  File.open(filename, 'w') do |f|
    f.puts 'Mrs. 2'
    f.puts 'Ciara 1'
    f.puts 'Dr. 1'
    f.puts 'Brandyn 1'
    f.puts 'Daren 1'
    f.puts 'Keara 1'
    f.puts 'Abdul 1'
  end
end

def create_test_suffix_file(filename)
  File.open(filename, 'w') do |f|
    f.puts 'DVM 2'
    f.puts 'Stamm 1'
    f.puts 'Maggio 1'
    f.puts 'Parisian 1'
    f.puts 'II 1'
    f.puts 'Bins'
    f.puts 'MD 1'
  end
end

describe Analyze do

  # Set up the files need for the specifications
  # put them down in the spec folder so they don't clutter the project root folder

  before(:all) do
    create_test_customer_file 'spec/test_customer_file.txt'
    create_test_prefix_file 'spec/expected_prefix.txt'
    create_test_suffix_file 'spec/expected_suffix.txt'
  end

  # clean up after ourselves

  after(:all) do
    File.delete 'spec/test_customer_file.txt'
    File.delete 'spec/expected_prefix.txt'
    File.delete 'spec/expected_suffix.txt'
    File.delete 'spec/output_prefix.txt'
    File.delete 'spec/output_suffix.txt'
  end

  it 'should take a flag, input a file and output file with extracted prefixes' do
    `ruby bin/txt2csv.rb analyze -t p -i spec/test_customer_file.txt -o spec/output_prefix.txt`
    IO.read('spec/output_prefix.txt').should == IO.read('spec/expected_prefix.txt')
  end

  it 'should take a flag, input a file and output file with extracted suffixes' do
    `ruby bin/txt2csv.rb analyze -t s -i spec/test_customer_file.txt -o spec/output_suffix.txt`
    IO.read('spec/output_suffix.txt').should == IO.read('spec/expected_suffix.txt')
  end

end
