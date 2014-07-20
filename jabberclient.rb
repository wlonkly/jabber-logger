
#
# set up global jabber connection
#

# TODO: debug config flag
Jabber::debug = true
cl = Jabber::Client.new(Jabber::JID.new($jid))
cl.connect
cl.auth($pass)

$m = Jabber::MUC::SimpleMUCClient.new(cl)
$m.join($room + "/" + $nick, $chatpass)

$m.on_message { |time,nick,text|
    if(time == nil)
       debug("<#{nick}> #{text}")
    end
}
