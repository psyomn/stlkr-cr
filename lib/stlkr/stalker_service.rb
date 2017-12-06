require 'stlkr'
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
      ws.each do |w|
        prev = w.hashcode
        w.fetch!
        new = w.hashcode

        if prev != new
          print "[#{Time.now}] Changed: #{w}"
          w.insert
        end

        puts
      end
      sleep Stlkr::INTERVAL
    end
  end

  attr_accessor :done
  attr_accessor :last_date

  private

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
