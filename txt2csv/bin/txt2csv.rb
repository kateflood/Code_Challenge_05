#!/usr/bin/env ruby

require 'thor'
require_relative '../lib/parse_test.rb'
require_relative '../lib/analyze.rb'

class Txt2Csv < Thor

	#this will analyze the incoming file for name prefixes and name suffixes
	
	desc "analyze TYPE INPUT OUTPUT", "Analyzes a file and returns either a suffix file or a prefix file"
	long_desc <<-LONGDESC 
		'txt2csv analyze' takes three required arguments: type, input and output.

		The type flag takes either a 'p' or 's' to indicate if the file should be analyzed for prefixes or suffixes.

		Input should be the file to be analyzed and should be in the format: 'name_string \\t phone_string \\t twitter_handle \\t email_address'

		Output should the name of the file you would like the analyzed data to print to.

	LONGDESC


	method_option :t, :aliases => '--type', :required => true, :desc => "accepts 'p' or 's' to indicate prefix or suffix file."
	method_option :i, :aliases => '--input', :required => true, :desc => "the input data"
	method_option :o, :aliases => '--output', :required => true, :desc => "the output file"

	def analyze
		# begin
			Analyze.new(options[:t], options[:i], options[:o]).get_name_field
		# rescue
		#  	puts "AnalyzeError."
		# end
	end

	#this will use the edited prefix and suffix files to convert the incoming file into clean csv
	desc "convert PREFIX_FILE SUFFIX_FILE INPUT OUTPUT", "Converts the input into a csv output"
	long_desc <<-LONGDESC 
		'txt2csv convert' takes four required arguments: prefix, suffix, input and output.

		Prefix should be the generated file from 'txt2csv analyze' utilizing the p argument for the -t flag.

		Suffix should be the generated file from 'txt2csv analyze' utilizing the s argument for the -t flag.

		Input should be the file to be converted and should be in the format: 'name_string \\t phone_string \\t twitter_handle \\t email_address'

		Output should the name of the csv file you would like the converted data to print to.

	LONGDESC

	method_option :p, :aliases => '--prefix', :required => true, :desc => "indicates a prefix file"
	method_option :s, :aliases => '--suffix', :required => true, :desc => "indicates a suffix file" 
	method_option :i, :aliases => '--input', :required => true, :desc => "the input data"
	method_option :o, :aliases => '--output', :required => true, :desc => "the output file"

	def convert

		Parse.new(options[:s], options[:p], options[:i], options[:o]).parse_customers

	end 

end

Txt2Csv.start

