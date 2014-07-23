#
# set up global jabber connection
#

def jabber_connect
  $logger.info "Connecting to Jabber..."
  Jabber::debug = $config['jabber']['debug'] || false
  client = Jabber::Client.new(Jabber::JID.new($config['jabber']['jid']))
  client.connect($config['jabber']['server'])
  client.auth($config['jabber']['password'])
  client
end

def jabber_join_muc (client, room)
  muc = Jabber::MUC::SimpleMUCClient.new(client)
  muc.join(room  + "/" + $config['jabber']['muc_nick'])
  $logger.info "Joined #{room}"
  muc
end
