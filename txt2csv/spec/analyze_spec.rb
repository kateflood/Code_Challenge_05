require 'spec_helper'
require 'pry'
require 'analyze.rb'

# First, define methods used to create the test files.
# We create the test files here
#   1) so that the test can be run on its own and
#   2) so the contents of the file are clear

def create_test_file(filename)
  File.open(filename, 'w') do |f|
    5.times  { f.puts 'Mr. Jones' }
    6.times  { f.puts 'Miss Smith' }
    4.times  { f.puts 'Mrs. Wesson' }
    10.times { f.puts 'Dr. Roberts' }
    1.times  { f.puts 'Jane Wintermute' }
    2.times  { f.puts 'Frank Franklin' }
    3.times  { f.puts 'Darleen Washington' }
  end
end

def create_prefix_expected_file(filename)
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

def create_suffix_expected_file(filename)
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

def create_test_customer_file(filename)
  File.open(filename, 'w') do |f|
    f.puts 'Miss First Last\t(123)456-7890\t@twitter\temail@example.com'
  end
end

def create_empty_test_file(filename)
  File.open(filename, 'w') do |f|
  end
end


describe Analyze do

  # Set up the files need for the specifications
  # put them down in the spec folder so they don't clutter the project root folder

  before(:all) do
    create_test_file 'spec/testfile.txt'
    create_prefix_expected_file 'spec/expected_prefixes.txt'
    create_suffix_expected_file 'spec/expected_suffixes.txt'
    create_test_customer_file 'spec/customer_file.txt'
    create_test_customer_file 'spec/empty_file.txt'
  end

  # clean up after ourselves

  after(:all) do
    File.delete 'spec/testfile.txt'
    File.delete 'spec/expected_prefixes.txt'
    File.delete 'spec/expected_suffixes.txt'
    File.delete 'spec/customer_file.txt'
    File.delete 'spec/histogram.txt'
    File.delete 'spec/empty_file.txt'
  end

  it 'should interpret the switch and return the correct pattern' do
    return_pattern = Analyze.get_type('p')
    expect(return_pattern).to eq (/^\S*/)
  end

  it 'should throw an error if inapplicable switch is used' do
    pending
    return_error = Analyze.get_type('v')
    expect(return_error).to eq "'s' or 'p' are only type options accepted."
  end

  it 'should read a file and return the name string' do
    pending
    return_string = Analyze.get_name_field('spec/customer_file.txt',  /^\S*/, {:Miss => 1})
    expect(return_string).to eq ('Miss First Last')
  end

  it 'should match a string and add/append to a histogram' do
    pending
    return_hash = Analyze.analyze_input("Miss First Last", /^\S*/, {:Miss => 1})
    expect(return_hash).to eq ({:Miss => 2})
  end

  it 'should write a hash to an output' do
    pending
    return_file = Analyze.export_output("spec/histogram.txt", {:Miss => 1})
    IO.read('spec/histogram.txt').should == "Miss 1\n"
  end


end
