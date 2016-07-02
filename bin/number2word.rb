#!/usr/bin/env ruby

lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'number2word'
include Number2Word
puts convert(ARGV[0])
