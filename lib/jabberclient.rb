
#
# set up global jabber connection
#

def connect_jabber_muc
    $logger.info "Connecting to Jabber..."
    Jabber::debug = $config['jabber']['debug'] || false
    cl = Jabber::Client.new(Jabber::JID.new($config['jabber']['jid']))
    cl.connect
    cl.auth($config['jabber']['password'])

    m = Jabber::MUC::SimpleMUCClient.new(cl)
    m.join($config['jabber']['muc_room'] + "/" + $config['jabber']['muc_nick'], 
           $config['jabber']['muc_password'])
    $logger.info "Connected."
    return m
end
