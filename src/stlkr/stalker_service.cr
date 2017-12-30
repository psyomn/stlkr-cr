require "../stlkr.cr"
require "time"

module Stlkr
class StalkerService
  def initialize
    @done = false
    @last_date = read_last_timestamp
  end

  def run
    loop do
      begin
        ws = load_websites
        until @done
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
      rescue e
        puts "Problem reaching sources: #{e}"
      end
    end
  end

  property done : Bool
  property last_date : Time | Nil

  private def db_changed?
    if @last_date != read_last_timestamp
      puts "Updating file list"
      @last_date = read_last_timestamp
      true
    else
      false
    end
  end

  private def timestamp_file_exists?
    File.exists? TIMESTAMPFILE
  end

  private def read_last_timestamp
    return File::Stat.new(TIMESTAMPFILE).mtime if timestamp_file_exists?
    nil
  end

  private def load_websites
    Website.all
  end
end
end
