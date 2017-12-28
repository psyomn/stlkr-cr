#!/usr/bin/env ruby

root = File.expand_path(File.join(File.dirname(__FILE__),'..'))
if File.directory?(File.join(root,'.git'))
  Dir.chdir(root) do
    begin
      require 'bundler/setup'
    rescue LoadError => e
      warn e.message
      warn "Run `gem install bundler` to install Bundler"
      exit(-1)
    end
  end
end

require 'stlkr'
require 'optparse'

include Stlkr
Boot.up!

options = {}
OptionParser.new do |opts|
  opts.banner = "stlkr: [options]"

  opts.on('-a', '--add-link <url>', 'add a link to monitor') do |v|
    options[:add_link] = v
  end

  opts.on('-d', '--delete-link <link-id>', 'delete link from monitor list') do |v|
    options[:delete_link] = v
  end

  opts.on('-s', '--start-service', 'start the stalker service') do |v|
    options[:start_service] = v
  end

  opts.on('-x', '--stop-service', 'stop the stalker service') do |v|
    options[:stop_service] = v
  end

  opts.on('-l', '--ls-sites', 'list the websites monitored') do |v|
    options[:ls] = v
  end

  opts.on('-u', '--username USERNAME', 'set the http username') do |v|
    options[:username] = v
  end

  opts.on('-p', '--password PASSWORD', 'set the http password') do |v|
    options[:password] = v
  end
end.parse!

if options[:add_link]
  w = Website.new(options[:add_link])
  w.username = options[:username]
  w.password = options[:password]
  w.insert
elsif options[:delete_link]
  w = Website.delete options[:delete_link]
elsif options[:start_service]
  th = Thread.new do
    ss = StalkerService.new
    ss.run
  end
  th.run
  th.join
elsif options[:ls]
  Website.all.each do |site|
    puts site.url
  end
end
