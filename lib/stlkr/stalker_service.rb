require 'stlkr'
require 'libnotify'
require 'gtk2'
require 'time'

module Stlkr
# @author psyomn
class StalkerService

  def initialize
    @done = false
    @last_date = read_last_timestamp
  end

  def run
    ws = load_websites
    until @done do
      ws = db_changed? ? load_websites : ws
      puts 'refresh'
      ws.each do |w|
        prev = w.hashcode
        print "Rechecking #{w} ..."
        w.fetch!
        new = w.hashcode

        if prev != new
          print " Site has changed!"
          w.insert
          notify_changed(w) if libnotify_enabled
        end

        puts
      end
      sleep Stlkr::INTERVAL
    end
  end

  attr_accessor :libnotify_enabled
  attr_accessor :done
  attr_accessor :last_date

  private

  def notify_changed(w)
    Libnotify.show(
      :body => "#{w.url}",
      :summary => "#{w.url} has changed",
      :timeout => 2.5,
      :icon_path => "/usr/share/icons/Tango/scalable/emblems/emblem-system.svg"
    )
  end

  # TODO this should simply check file timestamp and see if it has been altered
  # since last read
  def db_changed?
    if timestamp_file_exists?
      # Check last file modification date (we just touch whenever updating)
      if @last_date != read_last_timestamp
        puts "Updating file list"
        @last_date = read_last_timestamp
        true
      else
        false
      end
    else
      false
    end
  end

  # Check if there is a timestamp file
  def timestamp_file_exists?
    File.exist? TIMESTAMPFILE
  end

  def read_last_timestamp
    return File.mtime(TIMESTAMPFILE) if timestamp_file_exists?
    nil
  end

  def load_websites
    Website.all
  end
end
end
