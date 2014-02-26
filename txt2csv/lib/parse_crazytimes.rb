# require 'csv'
# require 'pry'

# # This class parses!
# class Parse
#   def initialize(prefixfile, suffixfile, input)
#     # binding.pry
#     f = File.open(input, 'r+')
#     @customer = f.read
#     p = File.open(prefixfile, 'r+')
#     @prefixes = [(p.read).split("\s")]
#     # binding.pry
#     s = File.open(suffixfile, 'r+')
#     @suffixes = [(s.read).split("\s")]
#     # binding.pry
#     split_input(@customer)
#   end

#   def self.split_input(customer)
#     @customer = @customer.split("\n")
#     @customer.map! { |x| x.split("\t") }
#     @customer
#     # binding.pry
#   end

#   def self.parse_all(customer)
#     pull_names(@customer)
#     pull_phone(@customer)
#     pull_twitter(@customer)
#     pull_email(@customer)
#     # binding.pry
#     @parsed_input = [] << @name << @phone << @twitter << @email
#     # binding.pry
#     @parsed_input
#   end

#   def self.pull_names(customer)
#     @name_string = @customer.map { |x| x[0] }
#     @name_string.map! { |x| x.split("\t") }
#     parse_names(@prefixes, @suffixes, @name_string)
#     # binding.pry
#   end

#   def self.parse_names(prefixes, suffixes, name_string)
#     parsed_name = { pre: [], first: [], middle: [], last: [], suffix: [] }
#     prefixes = nil ? prefixes = '' : prefixes
#     suffixes = nil ? suffixes = '' : suffixes
#     # binding.pry

#     @name_string.each do |word|
#       parsed_name[:suffix] << word.pop if @suffixes.include? word.pop
#       parsed_name[:last] << word.pop
#       parsed_name[:pre] << word.shift if @prefixes.include? word.shift
#       parsed_name[:first] << word.shift if word.count > 1
#       parsed_name[:middle] << word.first if word.count > 1
#     end    

#     # @name_string.each do |word|
#     #   parsed_name[:suffix] = word.pop if @suffixes.include? word.pop
#     #   parsed_name[:last] = word.pop
#     #   parsed_name[:pre] = word.shift if @prefixes.include? word.shift
#     #   parsed_name[:first] = word.shift if word.count > 1
#     #   parsed_name[:middle] = word.first if word.count > 1
#     # end

#     @name = parsed_name.values
#   end

#   def self.pull_phone(customer)
#     @phone_string = @customer.map { |x| x[1] }
#     parse_phone(@phone_string)
#     # binding.pry
#   end

#   def self.parse_phone(phone_string)
#     parsed_phone = { country: [], area: [], prefix: [], line: [], extension: [] }

#     phone_string.gsub!(/\W/, ' ')
#     phone = phone_string.split
#     parsed_phone[:extension] = phone.pop.sub(/x/, '') if phone_string.match(/x/)
#     parsed_phone[:line] = phone.pop
#     parsed_phone[:prefix] = phone.pop
#     parsed_phone[:area] = phone.pop
#     parsed_phone[:country] = phone.pop if phone.count > 0

#     @phone = parsed_phone.values
#   end

#   def self.pull_twitter(customer)
#     @twit_string = @customer.map { |x| x[2] }
#     parse_twitter(@twit_string)
#     # binding.pry
#   end

#   def self.parse_twitter(twit_string)
#     @twitter = []
#     @twitter << twit_string.gsub(/@/, '')
#   end

#   def self.pull_email(customer)
#     @email_string = @customer.map { |x| x[-1] }
#     parse_email(@email_string)
#     # binding.pry
#   end

#   def self.parse_email(email_string)
#     @email = []
#     @email.push(email_string.match(/\S+@\S+\.\S+/) ? email_string : 'not found')
#   end

#   def self.convert(input, output)
#     i = File.open(input, 'r+')
#     @input = i.read
#     # binding.pry
#     split_input(@input)
#     parse_all(@customer)
#     # binding.pry
#     CSV.open(output, 'a+') do |csv|
#       csv << @parsed_input.each
#     end
#   end

#   Parse.new('lib/prefixfile.txt', 'lib/suffixfile.txt').convert('lib/test.txt', 'lib/namefile.csv')
# end
