# logtail.rb: log-tailing part of falebot-ruby

def process_line (path, line)
  $logger.debug "Pre:  #{path}: #{line}"

  c = $config['logfiles'][path]

  excludes = c['exclude'] || []
  excludes.each do |exclude|
    # TODO: precompile regexps on startup
    if Regexp.new(exclude).match(line)
      $logger.debug "Line matches /#{exclude}/, excluding"
      return nil
    end
  end
  
  filters =  c['filter'] || []     
  filters.each do |filter|
    line.gsub!(Regexp.new(filter['replace']), filter['with'])
  end
  $logger.debug "Post: #{path}: #{line}"

  line
end

def tail_logs_forever 
  # explicitly disable sincedb, independent runs should be completely independent.
  # i'm not sure if i've missed mysterious implications of this but it APPEARS that
  # it's kept in memory and just cached to the sincedb file at intervals.
  t = FileWatch::Tail.new(:stat_interval => 1, :sincedb_path => '/dev/null')
  
  j = jabber_connect()
  muc = Hash.new

  $config['logfiles'].keys.each do |path|
    # only join each jabber MUC once, even if multiple files log to that MUC
    room = $config['logfiles'][path]['room']
    unless muc[room]
      $logger.info "Joining #{room} for #{path}"
      muc[room] = jabber_join_muc(j, room)
    end

    $logger.info "Watching #{path}"
    t.tail(path)
  end

  # watch endlessly
  t.subscribe do |path, line|
    l = process_line(path, line)
    if l 
      room = $config['logfiles'][path]['room']
      muc[room].say(l)
    end
  end
end 

