# logtail.rb: log-tailing part of falebot-ruby

def process_line (path, line)
    c = $config['logfiles'][path]

    c['exclude'].each do |exclude|
        # TODO: precompile regexps on startup
        if Regexp.new(exclude).match(line)
            return nil
        end
    end

    c['filter'].each do |filter|
        puts filter['replace']
        line.gsub!(Regexp.new(filter['replace']), filter['with'])
    end

    return line
end

def tail_logs_forever 
    # explicitly disable sincedb, independent runs should be completely independent.
    # i'm not sure if i've missed mysterious implications of this but it APPEARS that
    # it's kept in memory and just cached to the sincedb file at intervals.
    t = FileWatch::Tail.new(:stat_interval => 1, :sincedb_path => '/dev/null')

    $config['logfiles'].keys.each do |path|
        t.tail(path)
    end 

    t.subscribe do |path, line|
        l = process_line(path, line)
        if l 
            $muc.say(l)
        end
    end
end 

