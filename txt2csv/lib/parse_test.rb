require 'pry'
require 'csv'
# This class parses!
class Parse
  def initialize(suffix, prefix, input, output)
    @input = input
    @output = output
    @suffix_file = suffix
    @prefix_file = prefix
  end

  def parse_customers
    create_suffix_array
    create_prefix_array
    hdr = %w(prefix first middle last suffix country_code area_code ph_prefix line extension twitter email)
    csv_file = CSV.open(@output, 'a+', :headers => true) do | csv |
      csv << hdr # add headers to csv file
      File.open(@input) do | file |
        file.each_line do | line |
          str = line.split("\t")
          line_array = parse_each_line(str)
          csv << line_array.flatten
        end
      end
    end
  end

  def create_suffix_array
    @suffix = []
    IO.foreach(@suffix_file) { |line| @suffix << line.sub(/[^a-zA-Z]+/, '') }
  end

  def create_prefix_array
    @prefix = []
    IO.foreach(@prefix_file) { |line| @prefix << line.sub(/[^a-zA-Z\.]+/, '') }
  end

  def parse_each_line(cust_array)
    csv_array = []
    csv_array[0] = parse_names(@prefix, @suffix, cust_array[0])
    csv_array[1] = parse_phone(cust_array[1])
    csv_array[2] = parse_twitter(cust_array[2])
    csv_array[3] = parse_email(cust_array[3])
    csv_array
  end

  def parse_names(prefixes, suffixes, name_string)
    parsed_name = { pre: '', first: '', middle: '', last: '', suffix: '' }

    word = name_string.split
    parsed_name[:suffix] = word.pop if suffixes.include? word.last
    parsed_name[:last] = word.last
    parsed_name[:pre] = word.shift if prefixes.include? word.first
    parsed_name[:first] = word.shift if word.count > 1
    parsed_name[:middle] = word.first if word.count > 1

    parsed_name.values
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

    parsed_phone.values
  end

  def parse_twitter(twit_string)
    twitter = []
    twitter << twit_string.gsub(/@/, '')
  end

  def parse_email(email_string)
    email = []
    email.push(email_string.match(/\S+@\S+\.\S+/) ? email_string.chomp : 'not found')
  end
end
