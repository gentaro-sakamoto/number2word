module Number2Word
  def convert(num)
    valid_num = validate(num)
    return 'zero' if valid_num.zero?
    puts valid_num
  end

  def validate(num)
    string_num = num.to_s
    raise 'You need to pass a number' if string_num.empty?
    num_without_whtiespace_or_comma = string_num.gsub(/[\s,]/ ,"")
    raise 'You can only pass arabic numerals' unless num_without_whtiespace_or_comma =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
    num_without_whtiespace_or_comma.to_i
  end
end
