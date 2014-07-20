#!/usr/bin/env ruby

require 'file-tail'


t = Thread.new {
    log = File.open("./logfile")
    log.extend(File::Tail)
    log.interval = 1
    log.tail { |line| puts "1: #line" }
}

