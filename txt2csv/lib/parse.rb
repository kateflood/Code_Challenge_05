require 'csv'

# This class parses!
class Parse
  def initialize(input, output)
    @@input = File.open(input, "r+")
    @@output = File.open(output, "w+")
  end

  def self.split_input(input)
    for @@input do |line|
      customer = lines.split("\t")
      @name_string = customers[0]
      @phone_string = customers[1]
      @twit_string = customers[2]
      @email_string = customers[-1]
    end
  end

  # def self.split_input(input)
  #   attr :accessor
  #   File.open(input).each_line do |line|
  #     @customer = lines.split("\t")
  #     @customer[0] = :name_string
  #     @customer[1] = :phone_string
  #     @customer[2] = :twit_string
  #     @customer[-1] = :email_string
  #   end
  #   customers = [ @customer ]
  # end

  def self.parse_names(prefixes, suffixes, name_string)
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

  Parse.new("lib/test.txt", "histogram.txt")
end
