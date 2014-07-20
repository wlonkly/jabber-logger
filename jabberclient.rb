
#
# set up global jabber connection
#

def jabber_connect (config)
    Jabber::debug = config['debug']
    cl = Jabber::Client.new(Jabber::JID.new(config['jabber']['jid']))
    cl.connect
    cl.auth(config['jabber']['password'])

    m = Jabber::MUC::SimpleMUCClient.new(cl)
    m.join(config['jabber']['muc_room'] + "/" + config['jabber']['muc_nick'], 
           config['jabber']['muc_password'])
    return m
end
