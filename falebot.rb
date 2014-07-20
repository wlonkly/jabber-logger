#!/usr/bin/env ruby
require "rubygems"
require 'xmpp4r'
require 'xmpp4r/muc/helper/simplemucclient'
require "filewatch/tail"

# jabber server credentials
$jid  = 'test3@jabber.freshbooks.com'
$pass = 'testing'

# groupchat details
$room = 'fale2@conference.jabber.freshbooks.com'
$nick = 'fale2'
$chatpass = ''

def debug (message)
  time = Time.now.strftime("%H:%M:%S")
  puts "[" + time + "] " + message
end

require './jabberclient.rb'
require 'logtail.rb'
