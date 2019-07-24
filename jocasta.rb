#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

# This script is based on a script by ReSwift that can be found at
# https://github.com/ReSwift/ReSwift/blob/master/.scripts/doc-preprocessor

def parse_options(paired_args)
  options = { args: [] }
  index = 0
  while index < ARGV.length
    arg = ARGV[index]

    paired_key = paired_args[arg]
    if paired_key
      if index >= ARGV.length - 1
        puts "Unable to find a value for the arg: '#{arg}'"
        exit 1
      end
      options[paired_key] = ARGV[index + 1]
      index += 1
    elsif /--.+/ =~ arg
      puts 'unknown option: ' + arg
    else
      options[:args].push arg
    end
    index += 1
  end
  options
end

def require_args(args, count)
  return unless args.length != count

  puts 'usage: docgen [input] [output] [level] [section] [...options]'
  exit 1
end

def get_section(content, level, section)
  result = nil
  found = false
  content.split("\n").each do |line|
    if /^\#{#{level}}\s*#{section}\s*$/ =~ line
      result = ''
      found = true
    else
      next unless found

      break if /^\#{1,#{level}}\s*\w/ =~ line

      result += "\n" + line
    end
  end
  result
end

paired_args = {
  '--title' => :title,
  '--transforms' => :transforms
}
options = parse_options paired_args

require_args options[:args], 4
file_in = options[:args][0]
file_out = options[:args][1]
level = options[:args][2].to_i
section_name = options[:args][3]

input = IO.read(file_in)

# -----

result = get_section input, level, section_name
unless result
  puts "Unable to find section: '" + section_name + "'"
  exit 1
end

level_hash = ''
(1..level).each do
  level_hash += '#'
end
result = "#{level_hash} #{options[:title]}\n" + result if options[:title]

# -----

if result == ''
  puts 'Not writing output as result is empty'
  exit 1
end

IO.write(file_out, result)

puts "[Processed]: #{file_out}"
