#!/usr/bin/env ruby
# this first line is how the operating system knows to use ruby to execute file
# use chmod oug+x txt2csv to make sure the file is executable

require 'thor'
require_relative '../lib/analyze.rb'
require_relative '../lib/parse.rb'

# puts 'This is where txt2csv will be invoked from the command line.'

class TXT2CSV < Thor
  class_option :v, aliases: ['--verbose'],
                desc: 'Global option that provides extended command information',
                type: => :boolean

  # desc 'analyze', 'a command that analyzes the raw text file'
  # def analyze
  #   Analyze.new(-p, 'lib/test.txt', 'prefix.csv')
  # end

  method_option :p, aliases: ['--prefixes'],
            required: 'true'
                desc: 'command option to identify prefix file'
              banner: 'prefixes'
  method_option :s, aliases: ['--suffixes']
            required: 'true'
                desc: 'command option to identify suffix file'
              banner: 'suffixes'
  method_option :i, aliases: ['--input']
            required: 'true'
                desc: 'command option to identify input file'
              banner: 'input'
  method_option :o, aliases: ['--output']
            required: 'true'
                desc: 'command option to identify the output histogram file'
              banner: 'output'

  desc 'convert', 'a command that converts raw text file into parsed CSV file'
  long_desc <<-LONGDESC 
    'txt2csv convert' takes the prefix and suffix files produced by the analyze command and uses them to convert the raw text file into an clean csv file divided by names, phone numbers, twitter handles, and email addresses.
  LONGDESC
  def convert
    Parse.new(options[:s], options[:p], options[:i], options[:o])
  end
end

txt2csv.start
