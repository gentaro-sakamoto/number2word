INITIALIZER = -1
require File.expand_path("../data/big_numbers.rb",File.dirname(__FILE__))
require File.expand_path("../data/sub_one_thousand.rb",File.dirname(__FILE__))
module Number2Word
  def convert(num)
    negative = false
    valid_num = validate(num)
    return 'zero' if valid_num.zero?
    if valid_num < 0
      valid_num = valid_num.abs
      negative = true
    end

    processing_num = valid_num
    stack = []
    i = 0
    until processing_num.zero?
      word = ''
      processing_num, remainder = processing_num.divmod(1000)
      word << BIG_NUMBERS[i] if processing_num.nonzero? && processing_num != 1000
      word << (word.empty? ? '' : ' ') + "#{SUB_ONE_THOUSAND[remainder]}" if remainder.nonzero? && remainder.is_a?(Integer)
      stack << word
      i = i.succ
    end
    words = (negative ? 'negative ' : '') \
      + stack.reverse.join(' ') \
      + (valid_num.is_a?(Float) ? ' point ' + valid_num.to_s.split('.')[1].split(//).map{|e| SUB_ONE_THOUSAND[e.to_i]}.join(' ') : '')
  end

  def validate(num)
    string_num = num.to_s
    raise 'You need to pass a number' if string_num.empty?
    num_without_whtiespace_or_comma = string_num.gsub(/[\s,]/ ,"")
    raise 'You can only pass arabic numerals' unless num_without_whtiespace_or_comma =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
    /\./ =~ num_without_whtiespace_or_comma ? num_without_whtiespace_or_comma.to_f : num_without_whtiespace_or_comma.to_i
  end
end
