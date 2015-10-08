#!/usr/bin/env ruby

require 'structurebutcher'

body_file = ARGV[0]
slot      = ARGV[1]
part_file = ARGV[2]
format    = ARGV[3] || part_file.split('.').pop

butcher = StructureButcher.new
part = butcher.amputate_file(body_file, slot, part_file, format)
