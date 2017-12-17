require 'stlkr'
require 'time'

module Stlkr
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
          print "[#{Time.now}] Changed    : #{w}"
          w.insert
        else
          print "[#{Time.now}] Not Changed: #{w}"
        end

        puts
      end
      sleep Stlkr::INTERVAL
    end
  rescue => e
    puts "Problem reaching sources: #{e}"
    retry
  end

  attr_accessor :done
  attr_accessor :last_date

  private

  def db_changed?
    if @last_date != read_last_timestamp
      puts "Updating file list"
      @last_date = read_last_timestamp
      true
    else
      false
    end
  end

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
