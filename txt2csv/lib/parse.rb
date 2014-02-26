require 'csv'
require 'pry'

# This class parses!
class Parse
  def initialize(prefixfile, suffixfile, input, output)
    # binding.pry
    @customers = (File.open(input, 'r+')).read
    @output = output
    p = File.open(prefixfile, 'r+')
    @prefixes = [(p.read).split("\s")]
    # binding.pry
    s = File.open(suffixfile, 'r+')
    @suffixes = [(s.read).split("\s")]
    # binding.pry
    @customers.each_line do |line|
      @customer = line.split("\t")
      parse_all(@customer)
      convert(@output)
    end
  end

  def parse_all(customer)
    pull_names(@customer)
    pull_phone(@customer)
    pull_twitter(@customer)
    pull_email(@customer)
    # binding.pry
    @parsed_input = @name << @phone << @twitter << @email
    # binding.pry
    @parsed_input
  end

  def pull_names(customer)
    @name_string = @customer[0]
    @name_string.split("\t")
    parse_names(@prefixes, @suffixes, @name_string)
    # binding.pry
  end

  def parse_names(prefixes, suffixes, name_string)
    parsed_name = { pre: '', first: '', middle: '', last: '', suffix: '' }

    word = name_string.split
    parsed_name[:suffix] = word.pop if suffixes.include? word.last
    parsed_name[:last] = word.last
    parsed_name[:pre] = word.shift if prefixes.include? word.first
    parsed_name[:first] = word.shift if word.count > 1
    parsed_name[:middle] = word.first if word.count > 1

    @name = parsed_name.values
  end

  def pull_phone(customer)
    @phone_string = @customer[1]
    parse_phone(@phone_string)
    # binding.pry
  end

  def parse_phone(phone_string)
    parsed_phone = { country: '', area: '', prefix: '', line: '', extension: '' }

    phone_string.gsub!(/\W/, ' ')
    phone = phone_string.split
    parsed_phone[:extension] = phone.pop.sub(/x/, '') if phone_string.match(/x/)
    parsed_phone[:line] = phone.pop
    parsed_phone[:prefix] = phone.pop
    parsed_phone[:area] = phone.pop
    parsed_phone[:country] = phone.pop if phone.count > 0

    @phone = parsed_phone.values
  end

  def pull_twitter(customer)
    @twit_string = @customer[2]
    parse_twitter(@twit_string)
    # binding.pry
  end

  def parse_twitter(twit_string)
    twitter = []
    twitter << twit_string.gsub(/@/, '')
  end

  def pull_email(customer)
    @email_string = @customer[-1]
    parse_email(@email_string)
    # binding.pry
  end

  def parse_email(email_string)
    email = []
    email.push(email_string.match(/\S+@\S+\.\S+/) ? email_string : 'not found')
  end

  def convert(output)
    # binding.pry
    CSV.open(output, 'a+') do |csv|
      csv << @parsed_input
    end
  end
end

Parse.new('lib/prefixfile.txt', 'lib/suffixfile.txt', 'lib/test.txt', 'lib/namefile.csv')
