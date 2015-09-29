#!/usr/bin/env ruby

require 'structbutcher'

body_file = ARGV[0]
slot      = ARGV[1]
part_file = ARGV[2]
format    = ARGV[3] || part_file.split('.').pop

butcher = StructButcher.new
part = butcher.amputate_file(body_file, slot, part_file, format)
