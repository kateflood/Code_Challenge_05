require 'pry'
require_relative 'prefixfile.txt'
require_relative 'suffixfile.txt'
#this class analyzes an input and outputs either a prefix or a suffix file
class Analyze

	def initialize(input, output)
		@histogram = Hash.new(0)
		@prefixes = File.open('prefixfile.txt')
		@suffixes = File.open('suffixfile.txt')
		@input = input
		@output = output
		@pattern = self.get_type(switch)
		self.get_name_field(@input)
	end
	
	def self.get_type(switch)
		#put error handling here for issues with option passed
		case switch
		when '-p'
	  		@pattern = /^\S*/
		when '-s'
	  		@pattern = /\S*$/
		else
			#throw up an error
		end
	end	

	def self.get_name_field(input)
		#iterate through input and remove name field
		File.open(input) do | file |
			file.each_line do | line | 
				s = line.split('\t')
				self.analyze_input(s[0])
			end
		end
		self.export_output(@output)
	end

	def self.analyze_input(name_string)
	  	w = regular_expression.match(name_string).to_s
	  	@histogram[w.to_sym] += 1
	end 

	def self.export_output(output)
		#reverse sort the histogram and print it to the output file/source
		histogram = Hash[ @histogram.sort_by { |word, count| count }.reverse]
		File.open(output) do | file |
			histogram.each { |word, count| puts "#{word} #{count}" }
		end
	end

end
