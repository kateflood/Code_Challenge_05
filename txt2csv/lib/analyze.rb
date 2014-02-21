require 'pry'

class Analyze
	attr_accessor :histogram
	attr_accessor :pattern
	attr_reader :switch
	attr_reader :input
	attr_reader :output

	def initialize(switch, input, output)
		@histogram = Hash.new(0)
		@switch = switch
		@input = input
		@output = output
		@pattern = getType
		getNameField
	end
	
	def getType
		#put error handling here for issues with option passed
		case @switch
		when '-p'
	  		@pattern = /^\S*/
		when '-s'
	  		@pattern = /\S*$/
		else
			#throw up an error
		end
	end	

	def getNameField
		#iterate through input and remove name field
		File.open(@input) do | file |
			file.each_line do | line | 
				s = line.split('\t')
				analyzeInput(s[0])
			end
		end
		binding.pry
		exportOutput
	end

	def analyzeInput(name_string)
	  	w = regular_expression.match(name_string).to_s
	  	histogram[w.to_sym] += 1
	end 

	def exportOutput
		#reverse sort the histogram and print it to the output file/source
		histogram = Hash[ @histogram.sort_by { |word, count| count }.reverse]
		File.open(@output) do | file |
			histogram.each { |word, count| puts "#{word} #{count}" }
		end
	end

end
