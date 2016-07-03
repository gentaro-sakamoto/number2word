#!/usr/bin/env ruby

require_relative("../lib/number2word")
include Number2Word
puts convert(ARGV[0])
