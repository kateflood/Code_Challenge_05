require 'pry'
#this class analyzes an input and outputs either a prefix or a suffix file
class Analyze
	attr_reader :switch
	attr_reader :input
	attr_reader :output
	attr_reader :pattern
	attr_reader :histogram

	def initialize(switch, input, output)
		@histogram = Hash.new(0)
		@input = input
		@output = output
		@switch = switch
		# @pattern = get_type(@switch)
		# get_name_field(@input, @pattern, @histogram)
		# export_output(@output)
	end
	
	def get_type(switch)
		#put error handling here for issues with option passed
		case switch
		when 'p'
	  		@pattern = /^\S*/
		when 's'
	  		@pattern = /\S*$/
		else
			#throw up an error
		end
	end	

	def get_name_field(input, pattern, histogram)
		#iterate through input and remove name field
		File.open(input) do | file |
			file.each_line do | line | 
				s = line.split('\t')
				analyze_input(s[0])
			end
		end
	end

	def analyze_input(name_string)
	  	w = @pattern.match(name_string).to_s
	  	@histogram[w.to_sym] += 1
	  	@histogram
	end

	def export_output(output, histogram)
		#reverse sort the histogram and print it to the output file/source
		h = Hash[ histogram.sort_by { |word, count| count }.reverse]
		File.open(output, "w") do | file |
			h.each { |word, count| file.puts "#{word} #{count}" }
		end
	end

end


