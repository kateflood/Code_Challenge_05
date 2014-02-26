require 'pry'
# this class analyzes an input and outputs either a prefix or a suffix file
class Analyze
  def initialize(switch, input, output)
    @histogram = Hash.new(0)
    @input = input
    @output = output
    @switch = switch
  end

  def get_type(switch)
    # put error handling here for issues with option passed
    case switch
    when 'p'
      /^\S*/
    when 's'
      /\S*$/
    else
      raise "Unknown type error."
    end
  end

  def parse_name_field
    reg_exp = get_type(@switch)
    f = File.open(@input) do | file |
      file.each_line do | line |
        s = line.split("\t")
        analyze_input(s[0], reg_exp)
      end
    end
    export_output
  end

  def analyze_input(name_string, reg_exp)
    pattern = reg_exp
    w = pattern.match(name_string).to_s
    @histogram[w.to_sym] += 1
    @histogram
  end

  def export_output
    h = Hash[ @histogram.sort_by { |word, count| count }.reverse]
    f = File.open(@output, 'w') do | file |
      h.each { |word, count| file.puts "#{word} #{count}" }
    end
  end
end
