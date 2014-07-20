#!/usr/bin/env ruby
require "rubygems"
require 'xmpp4r'
require 'xmpp4r/muc/helper/simplemucclient'
require "filewatch/tail"
require 'yaml'

# TODO: these go in lib/? how does one package a "program" with its supporting
# files in Ruby anyhow?
require './jabberclient.rb'
require './logtail.rb'

# TODO: separate yaml(?) config
config = YAML.load_file("./config.yml")

muc = jabber_connect(config)
tail_logs(config, muc)

# def debug (message)
#   time = Time.now.strftime("%H:%M:%S")
#  puts "[" + time + "] " + message
# end

