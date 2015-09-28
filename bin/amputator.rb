#!/usr/bin/env ruby

require 'structbutcher'

parser = StructButcher::Parser.new
struct = parser.load_struct(ARGV[0])

puts(struct)
