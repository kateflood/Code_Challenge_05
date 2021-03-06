#!/usr/bin/env ruby
# this first line is how the operating system knows to use ruby to execute file
# use chmod oug+x txt2csv to make sure the file is executable

require 'thor'

# puts 'This is where txt2csv will be invoked from the command line.'

class TXT2CSV < Thor
  class_option :v, aliases: ['--verbose']
                desc: 'Global option that provides extended command information'
                type: => :boolean

  option :p, aliases: ['--prefixes']
                desc: 'command option to analyze for prefixes'
  option :s, aliases: ['--suffixes']
                desc: 'command option to analyze for suffixes'
  option :i, aliases: ['--input']
                desc: 'command option to identify input file'
  option :o, aliases: ['--output']
                desc: 'command option to identify the output histogram file'

  desc 'analyze', 'a command that analyzes the raw text file'
  def analyze

  end

  option :p, aliases: ['--prefixes']
                desc: 'command option to identify prefix file'
  option :s, aliases: ['--suffixes']
                desc: 'command option to identify suffix file'
  option :i, aliases: ['--input']
                desc: 'command option to identify input file'
  option :o, aliases: ['--output']
                desc: 'command option to identify the output histogram file'

  desc 'convert', 'a command that converts raw text file into parsed CSV file'
  def convert

  end
end
