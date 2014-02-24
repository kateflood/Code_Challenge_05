require 'csv'
require 'pry'

# This class parses!
class Parse
  def initialize(input, output)
    @input = File.open(input, "r+")
    @output = File.open(output, "w+")

  end

  def parse_all(input)
    Parse.split_input(@input)
    @parsed = Parse.parse_lines(@customer)
    print @parsed
  end

  def self.split_input(input)
    f = File.open(input, "r+")
    # binding.pry
    f.each_line do |line|
      @customer = line
      @customer = @customer.chomp.split("\t")
    end
    @customer
  end

  def self.parse_lines(customer)
    customer = @customer
    prefixes = %w(M. Mrs. Mr. Dr. Ms. Sister Lady)
    suffixes = %w(Jr. Sr. II III IV PhD.)

    customer_info = @customer.to_a
    binding.pry
    names = Parse.parse_names(prefixes, suffixes, customer_info[0])
    binding.pry
    phone = Parse.parse_phone(customer_info[1])
    twitter = Parse.parse_twitter(customer_info[2])
    email = Parse.parse_email(customer_info[-1])

    parsed_customer = [names, phone, twitter, email]
  end
  #   parsed_file[:name_string] = @customer.each[0]
  #   parsed_file[:phone_string] = @customer.each[1]
  #   parsed_file[:twit_string] = @customer.each[2]
  #   parsed_file[:name_string] = @customer.each[-1]
  #   customers = [ @customer ]
  # end

  def self.parse_names(prefixes, suffixes, name_string)
    prefixes = %w(M. Mrs. Mr. Dr. Ms. Sister Lady)
    suffixes = %w(Jr. Sr. II III IV PhD.)
    parsed_name = { pre: '', first: '', middle: '', last: '', suffix: '' }

    word = name_string.split
    parsed_name[:suffix] = word.pop if suffixes.include? word.last
    parsed_name[:last] = word.last
    parsed_name[:pre] = word.shift if prefixes.include? word.first
    parsed_name[:first] = word.shift if word.count > 1
    parsed_name[:middle] = word.first if word.count > 1

    parsed_name.values
  end

  def self.parse_phone(phone_string)
    parsed_phone = { country: '', area: '', prefix: '', line: '', extension: '' }

    phone_string.gsub!(/\W/, ' ')
    phone = phone_string.split
    parsed_phone[:extension] = phone.pop.sub(/x/, '') if phone_string.match(/x/)
    parsed_phone[:line] = phone.pop
    parsed_phone[:prefix] = phone.pop
    parsed_phone[:area] = phone.pop
    parsed_phone[:country] = phone.pop if phone.count > 0

    parsed_phone.values
  end

  def self.parse_twitter(twit_string)
    twitter = []

    twitter << twit_string.gsub(/@/, '')
  end

  def self.parse_email(email_string)
    email = []
    email.push(email_string.match(/\S+@\S+\.\S+/) ? email_string : 'not found')
  end
end
