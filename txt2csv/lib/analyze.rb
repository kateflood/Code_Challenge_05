require 'pry'
#this class analyzes an input and outputs either a prefix or a suffix file
class Analyze

	def initialize(switch, input, output)
		@histogram = Hash.new(0)
		@input = input
		@output = output
		@pattern = self.get_type(switch)
		# get_name_field(@input)
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
				analyzeInput(s[0])
			end
		end
		exportOutput(@output)
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


