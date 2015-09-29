#!/usr/bin/env ruby

require 'structbutcher'

in_file  = ARGV[0]
slot     = ARGV[1]
out_file = ARGV[2]
format   = ARGV[3] || output.split('.').pop

parser = StructButcher::Parser.new
body   = parser.load_struct(filename)

butcher = StructButcher.new
part = butcher.amputate(body, slot)

storer = StructButcher::Storer.new
storer.save_struct(part, output, format)
