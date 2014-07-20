#!/usr/bin/env ruby
require "rubygems"
require "filewatch/tail"

t = FileWatch::Tail.new
t.tail("./logfile*")
t.subscribe do |path, line|
  puts "#{path}: #{line}"
end