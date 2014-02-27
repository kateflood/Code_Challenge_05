require 'spec_helper'
require 'pry'
require 'parse_test.rb'

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

def create_test_csv_file(filename)
  File.open(filename, 'w') do |f|
    f.puts 'prefix,first,middle,last,suffix,country_code,area_code,ph_prefix,line,extension,twitter,email'
    f.puts 'Mrs.,Theresa,E.,Stamm,"",1,678,523,6736,"",Reinger,kieran@runte.biz'
    f.puts '"",Keara,"",Maggio,"",1,399,471,4388,9581,Weber,cayla@lubowitz.com'
    f.puts '"",Daren,S.,Padberg,DVM,"",240,399,5583,73790,Hessel,augusta@stoltenberg.com'
    f.puts 'Mrs.,Sam,"",Parisian,"","",818,657,9309,5633,Quigley,lavon.quitzon@schinnercain.biz'
    f.puts '"",Ciara,X.,Windler,II,"",575,225,1469,240,Labadie,ryan_moore@hagenesmiller.com'
    f.puts '"Dr.","","","Bins",1,543,553,4396,596,"Borer","kay@abbottmoen.org"'
    f.puts '"","Brandyn","","Sawayn","MD","",976,736,2127,"","Weber","brenna@frami.biz"'
    f.puts '"","Abdul","","Halvorson","DVM","",511,476,6661,"","Casper","jeanne@friesen.biz"'
  end
end

describe Parse do

  before(:all) do
    create_test_customer_file 'spec/test_customer_file.txt'
    create_test_prefix_file 'spec/test_prefix.txt'
    create_test_suffix_file 'spec/test_suffix.txt'
    create_test_csv_file 'spec/expected_csv'
  end

  after(:all) do
    File.delete 'spec/test_customer_file.txt'
    File.delete 'spec/test_prefix.txt'
    File.delete 'spec/test_suffix.txt'
    File.delete 'spec/expected_csv'
    File.delete 'spec/test_csv'
  end

  it 'should take a flag, input a file and output file with extracted prefixes' do
    `ruby bin/txt2csv.rb convert -s spec/test_suffix.txt -p spec/test_prefix.txt -i spec/test_customer_file.txt -o spec/test_csv`
    IO.read('spec/test_csv').should == IO.read('spec/expected_csv')
  end

end
