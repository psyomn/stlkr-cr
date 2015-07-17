require 'stlkr'
require 'libnotify'

module Stlkr
# @author psyomn
class StalkerService
  def initialize
    @done = false
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
        end

        puts
      end
      sleep Stlkr::INTERVAL
    end
  end

  private

  def db_changed?
    true
  end

  def load_websites
    Website.all
  end
end
end
