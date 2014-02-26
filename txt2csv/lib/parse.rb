require 'csv'
require 'pry'

# This class parses!
class Parse
  def initialize(prefixfile, suffixfile)
    # binding.pry
    p = File.open(prefixfile, 'r+')
    @prefixes = [(p.read).split("\s")].flatten!
    # binding.pry
    s = File.open(suffixfile, 'r+')
    @suffixes = [(s.read).split("\s")].flatten!
    # binding.pry
  end

  def parse_all(customer)
    # binding.pry
    @parsed_input = [] << @name << @phone << @twitter << @email
    # binding.pry
    @parsed_input
  end

  def split_input(input)
    f = File.open(input, 'r+')
    @customer = f.read
    # binding.pry
    @customer = @customer.split("\n")
    # binding.pry
    @customer.map! { |x| x.split("\t") }
    @customer
    # binding.pry
  end

  def pull_names(customer)
    @name_string = @customer.map { |x| x[0] }
    @name_string.map! { |x| x.split("\s") }
    parse_names(@prefixes, @suffixes, @name_string)
    # binding.pry
  end

  def parse_names(prefixes, suffixes, name_string)
    parsed_name = { pre: [], first: [], middle: [], last: [], suffix: [] }
    # prefixes = nil ? prefixes = '' : prefixes
    # suffixes = nil ? suffixes = '' : suffixes
    
    name_string.each do |subarray|
      parsed_name[:suffix] << subarray[-1] if suffixes.include? subarray.last
      parsed_name[:last] << subarray[-1]
      parsed_name[:pre] << subarray[0] if prefixes.include? subarray[0]
      binding.pry
      parsed_name[:first] << subarray.shift if subarray.count > 1
      parsed_name[:middle] << subarray.first if subarray.count > 1
    end

    @name = parsed_name.values
  end

  def pull_phone(customer)
    @phone_string = @customer.map { |x| x[1] }
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
    @twit_string = @customer.map { |x| x[2] }
    parse_twitter(@twit_string)
    # binding.pry
  end

  def self.parse_twitter(twit_string)
    @twitter = []
    @twitter << twit_string.gsub(/@/, '')
  end

  def pull_email(customer)
    @email_string = @customer.map { |x| x[-1] }
    parse_email(@email_string)
    # binding.pry
  end

  def parse_email(email_string)
    @email = []
    @email.push(email_string.match(/\S+@\S+\.\S+/) ? email_string : 'not found')
  end

  def convert(input, output)
    # binding.pry
    split_input(input)
    parse_all(@customer)
    # binding.pry
    CSV.open(output, 'a+') do |csv|
      csv << @parsed_input.each
    end
  end

  Parse.new('lib/prefixfile.txt', 'lib/suffixfile.txt').convert('lib/test.txt', 'lib/namefile.csv')
end
