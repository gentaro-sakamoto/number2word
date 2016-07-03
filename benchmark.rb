require 'benchmark'
require_relative 'lib/number2word'

include Number2Word

Benchmark.benchmark do |x|
  x.report(:bin_num) { 100.times { |n| convert(rand(10**303..10**304)) } }
  x.report(:float) { 1000.times { |n| convert(rand) } }
end
