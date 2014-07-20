# logtail.rb: log-tailing part of falebot-ruby

# explicitly disable sincedb, independent runs should be completely independent.
# i'm not sure if i've missed mysterious implications of this but it APPEARS that
# it's kept in memory and just cached to the sincedb file at intervals.
t = FileWatch::Tail.new(:stat_interval => 1, :sincedb_path => '/dev/null')

# TODO: split into own file and make filters configurable
def process_line (path, line)
    $m.say("#{path}: #{line}")
end

# TODO: this goes in a config file
paths = ["/tmp/logfile","/tmp/logfile2"]

paths.each do |path|
   t.tail(path)
end 

t.subscribe do |path, line|
  process_line(path, line)
end

