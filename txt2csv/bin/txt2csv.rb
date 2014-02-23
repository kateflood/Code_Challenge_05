#!/usr/bin/env ruby

require 'thor'
require_relative '../lib/parse.rb'
require_relative '../lib/analyze.rb'

class Txt2Csv < Thor

	#this will analyze the incoming file for name prefixes and name suffixes
	
	desc "analyze TYPE INPUT OUTPUT", "Analyzes a file and returns either a suffix file or a prefix file"
	
	method_option :p, :aliases => "--prefix", :desc => "indicates prefix or suffix to analyze."  
	method_option :i, :aliases => "--input", :desc => "the input data"
	method_option :o, :aliases => "--output", :desc => "the output file"

	def analyze
	
		test = Analyze.new(options[:p], options[:i], options[:o])
		binding.pry
		test.get_type(test.switch)
		test.get_name_field(test.input, test.pattern, test.histogram)
		test.export_output(test.output, test.histogram)

	end

	#this will use the edited prefix and suffix files to convert the incoming file into clean csv
	desc "convert FILE", "Parses the file and returns a csv version of the data"

	#method_option :p, aliases: => "--prefix", :required, desc: => "indicates a prefix file"
	#method_option :s, aliases: => "--suffix", :required, desc: => "indicates a suffix file" 

	def convert

	end 

end

Txt2Csv.start

