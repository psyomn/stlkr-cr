# require 'stlkr'
require "option_parser"
require "./stlkr.cr"

include Stlkr
Boot.up!

options = Hash(Symbol, String).new
OptionParser.parse! do |opts|
  opts.banner = "stlkr: [options]"

  opts.on("-a", "--add-link <url>", "add a link to monitor") do |v|
    options[:add_link] = v
  end

  opts.on("-d", "--delete-link <link-id>", "delete link from monitor list") do |v|
    options[:delete_link] = v
  end

  opts.on("-s", "--start-service", "start the stalker service") do |v|
    options[:start_service] = v
  end

  opts.on("-x", "--stop-service", "stop the stalker service") do |v|
    options[:stop_service] = v
  end

  opts.on("-l", "--ls-sites", "list the websites monitored") do |v|
    options[:ls] = v
  end

  opts.on("-u", "--username USERNAME", "set the http username") do |v|
    options[:username] = v
  end

  opts.on("-p", "--password PASSWORD", "set the http password") do |v|
    options[:password] = v
  end
end

if options[:add_link]?
  url : String = options[:add_link].not_nil!
  w = Website.new(url)
  w.username = options[:username]?
  w.password = options[:password]?
  w.insert
elsif options[:delete_link]?
  w = Website.delete(options[:delete_link])
elsif options[:start_service]?
  ch = Channel(Nil).new
  spawn do
    ss = StalkerService.new
    ss.run
    ch.send(nil)
  end
  ch.receive
elsif options[:ls]
  Website.all.each do |site|
    puts site.url
  end
end
